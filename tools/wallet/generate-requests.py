from pathlib import Path
import re,zlib,json
r=Path(__file__).resolve().parents[2]
s='\n'.join(line for line in (r/'docs/wallet/methods.tl').read_text().splitlines() if line and not line.startswith(('//', '---')))
for line in s.splitlines():
 norm=re.sub(r'#[a-f0-9]+','',line.rstrip(';')).replace(':bytes ',':string ').replace('?bytes ','?string ').replace('<',' ').replace('>','')
 assert zlib.crc32(norm.encode())==int(line.split('#')[1].split()[0],16),line

header='''// Generated from docs/wallet/methods.tl. Response buffers remain unparsed here.
// These requests must be followed by the appropriate response decoder.
public enum WalletMTProto {
    public enum Replacement {
        case new
        case imported(publicKey: Buffer, proof: OwnershipProof)
        fileprivate func serialize(_ buffer: Buffer) {
            switch self {
            case .new: buffer.appendInt32(Int32(bitPattern: 0x63a440dc))
            case let .imported(publicKey, proof):
                buffer.appendInt32(Int32(bitPattern: 0x2959057c))
                serializeBytes(publicKey, buffer: buffer, boxed: false)
                proof.serialize(buffer)
            }
        }
    }
    public struct OwnershipProof {
        public let timestamp: Int32
        public let signature: Buffer
        public init(timestamp: Int32, signature: Buffer) {
            self.timestamp = timestamp
            self.signature = signature
        }
        fileprivate func serialize(_ buffer: Buffer) {
            buffer.appendInt32(Int32(bitPattern: 0x60bccb0d))
            buffer.appendInt32(timestamp)
            serializeBytes(signature, buffer: buffer, boxed: false)
        }
    }
    public typealias Request = (FunctionDescription, Buffer, DeserializeFunctionResponse<Buffer>)
    private static func request(_ name: String, _ buffer: Buffer) -> Request {
        // Never include passwords, proof signatures or encrypted secrets in log metadata.
        return (FunctionDescription(name: name, parameters: []), buffer, DeserializeFunctionResponse { $0 })
    }
'''
types={'#':'Int32','int':'Int32','long':'Int64','string':'String','bytes':'Buffer','InputUser':'Api.InputUser','InputCheckPasswordSRP':'Api.InputCheckPasswordSRP','InputWalletReplacement':'Replacement','WalletOwnershipProof':'OwnershipProof'}
def camel(n):return re.sub('_([a-z])',lambda m:m[1].upper(),n)
def swift(t):return '['+swift(t[7:-1])+']' if t.startswith('Vector<') else types[t]
def write(n,t,indent):
 if t.startswith('Vector<'):
  inner=t[7:-1];return [indent+'buffer.appendInt32(Int32(bitPattern: 0x1cb5c415))',indent+f'buffer.appendInt32(Int32({n}.count))',indent+f'for item in {n} {{']+write('item',inner,indent+'    ')+[indent+'}']
 if t in ['int','#','long']:return [indent+f'buffer.appendInt{64 if t=="long" else 32}({n})']
 if t in ['string','bytes']:return [indent+f'serialize{"String" if t=="string" else "Bytes"}({n}, buffer: buffer, boxed: false)']
 if t in ['InputWalletReplacement','WalletOwnershipProof']:return [indent+f'{n}.serialize(buffer)']
 return [indent+f'{n}.serialize(buffer, true)']
for line in s.splitlines():
 lhs=line.split(' = ')[0].split();name,cid=lhs[0].split('#');args=[];fields=[];flags=[]
 for field in lhs[1:]:
  n,t=field.split(':');n=camel(n);bit=None
  if '?' in t:
   f,t=t.split('?');bit=int(f.split('.')[1]);flags.append((n,bit))
  if t=='#':fields.append((n,t,None));continue
  args.append(f'{n}: {swift(t)}'+('?' if bit is not None else ''))
  fields.append((n,t,bit))
 if any(t=='#' for _,t,_ in fields):args.insert(0,'flags: Int32 = 0')
 method=name.split('.')[1]
 header+=f'    public static func {method}('+', '.join(args)+') -> Request {\n        let buffer = Buffer()\n        buffer.appendInt32(Int32(bitPattern: 0x'+cid+'))\n'
 if flags:
  mask=sum(1<<b for _,b in flags)
  header+=f'        var resolvedFlags = flags & ~Int32({mask})\n'
  for n,b in flags:header+=f'        if {n} != nil {{ resolvedFlags |= {1<<b} }}\n'
 for n,t,bit in fields:
  if t=='#':header+=f'        buffer.appendInt32({"resolvedFlags" if flags else "flags"})\n';continue
  if bit is not None:header+=f'        if let {n} {{\n'+'\n'.join(write(n,t,'            '))+'\n        }\n'
  else:header+='\n'.join(write(n,t,'        '))+'\n'
 header+=f'        return request("{name}", buffer)\n    }}\n'
header+='}\n'
(r/'submodules/TelegramApi/Sources/WalletMTProto.swift').write_text(header)
