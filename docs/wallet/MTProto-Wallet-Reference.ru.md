# Wallet / Toncenter MTProto: подробный справочник извлечённой схемы
Версия документа: 20 сентября 2026 года.
Билд-источник: Telegram macOS 12.10.283233.
Исходник запросов: [methods.tl](methods.tl).
Машинные свидетельства: [method-evidence.json](method-evidence.json).
Реализация запросов: [WalletMTProto.swift](../../submodules/TelegramApi/Sources/WalletMTProto.swift).
Документ описывает все 25 найденных методов: 23 из пространства wallet и 2 из toncenter.
Это описание исследованного клиента и текущего форка, а не официальная спецификация закрытого серверного API.
Наличие метода в бинарнике не доказывает его доступность любому аккаунту, в любом DC или на любом сервере.
Секреты аккаунтов, session-файлы, API hash, приватные ключи и recovery phrase в документ не включены.

## Как читать этот справочник
Для каждого метода приведены точная текущая сигнатура запроса, поля, порядок записи, результат, логика использования и ограничения знания.
**Подтверждено схемой/кодом** означает: это непосредственно присутствует в исправленном TL или в текущем сериализаторе.
**Наблюдалось** означает: ответ был получен в описанном тесте либо зафиксирован в сохранённых материалах проекта.
**Интерпретация** означает: вывод по названиям, типам, связям методов и структуре клиентского сценария.
**Не установлено** означает: нет достаточных данных для утверждения о сервере.
«Ожидаемый сценарий» ниже — порядок действий разрабатываемого клиента, а не восстановленный исходный код backend.
CRC32 используется для проверки согласованности декларации; это не доказательство полной семантики метода.
Поля optional подтверждают возможность отсутствия байтов в запросе, но не гарантируют принятие такого запроса сервером.
Размеры, лимиты, таймауты и названия ошибок не объявляются серверными требованиями, если они известны только из нашего клиента.
Объявления ответов находятся в responses.tl; их уровень подтверждения различается. Алгоритм клиентского backup восстановлен отдельно по машинному коду в конце справочника.

## Самое важное
Отдельный метод wallet.createWallet в исправленном наборе не найден.
Ближайший запрос — wallet.replaceWallet с вариантом inputWalletNew.
Новый локальный кошелёк и успешная регистрация кошелька в Telegram — разные состояния.
Текущий интерфейс генерирует ключи локально, сохраняет кошелёк, затем пытается зарегистрировать inputWalletImported.
wallet.getUserAddresses работает с Vector<InputUser>, а не с одиночным peer_id.
Его второй вектор addresses обязателен, даже когда пуст.
wallet.sendTransfer принимает обязательные data_normal и random_id; data_gasless опционален.
Нынешняя отправка в форке идёт через Toncenter JSON-RPC внутри MTProto-прокси, а не через wallet.sendTransfer.
toncenter.performApiRequest нельзя целиком классифицировать как read-only: эффект зависит от переданного endpoint/payload.
wallet.tonConnectNextEventId нельзя считать чистым чтением только по имени: получение следующего ID может менять счётчик.
wallet.exportSecretPhrase не следует смешивать с безобидным чтением баланса: это операция восстановления секрета.
Карточка-квитанция, отправляемая нашим приложением как изображение, не является новым доверенным серверным типом платежа.

## Источники и границы доверия
Приоритет 1: исправленный файл methods.tl в этом репозитории и совпадающий с ним Swift-сериализатор.
Приоритет 2: инструкции сериализатора в macOS-бинарнике и исправленные привязки строк/constructor ID.
Приоритет 3: конкретные ответы RPC, полученные с известным корректным телом запроса.
Приоритет 4: текущий прикладной Swift-код; он описывает наше поведение, но может содержать ошибочные предположения о сервере.
Приоритет 5: названия методов и предварительные типы из старых извлечений — полезные гипотезы, не спецификация.
В раннем извлечении ссылки Swift-строк были интерпретированы со сдвигом 32 байта.
Это привело к неверному сопоставлению имён и ID, хотя некоторые отдельные объявления случайно оставались правильными.
Файл Downloads/Telegram-12.10.283233.wallet.tl нельзя целиком использовать для генерации клиента.
Старые таблицы ошибок необходимо привязывать к реально отправленному ID, а не к подписи method в JSON-отчёте.
Например, старый «getUserAddresses» с ID d8c72eec фактически попадал в constructor нынешнего replaceWallet.
Ответы INPUT_REQUEST_TOO_LONG и INPUT_CONSTRUCTOR_INVALID в таком тесте не характеризуют корректный getUserAddresses.
В этом документе старые ошибочные подписи не используются как доказательства существования/поведения метода.

## Общая транспортная модель
Клиент авторизуется в MTProto и отправляет бинарный TL-запрос с constructor ID и аргументами.
Тип результата после знака равенства задаёт ожидаемый TL-ответ, а не HTTP content-type.
Часть запросов возвращает Updates; их нужно пропустить через обычный механизм обработки обновлений аккаунта.
Нельзя считать первое получение Updates подтверждением конкретной транзакции в блокчейне.
WalletState имеет восстановленный wire-формат; значение отдельных серверных состояний и переходов между ними остаётся backend-семантикой.
Методы Toncenter являются отдельным слоем транспорта для provider API, а не эквивалентом всех wallet.*.
Состояние Telegram-сессии, ключи TON-кошелька и ключи TON Connect — отдельные сущности.
Приватный ключ кошелька не является access_hash пользователя и не заменяет MTProto auth_key.
Разрешение username в InputUser даёт Telegram-идентичность; адрес для TON отдельно возвращает wallet.getUserAddresses.
Адрес TON и строковый ID транзакции нельзя использовать как Telegram peer_id.
Внутренние session_id TON Connect нельзя подставлять в MTProto session_id.
Поля random_id, app_request_id и msg_id решают разные задачи и не должны автоматически получать одно значение.

## Общая бинарная сериализация
Сначала пишется 32-битный constructor ID, затем поля строго слева направо по декларации.
int и flags занимают 4 байта; long занимает 8 байт; числовые значения записываются little-endian.
Вызов метода без параметров всё равно содержит его 4-байтный constructor ID.
Vector<T> в используемых запросах boxed: маркер 0x1cb5c415, число элементов int32 и сами элементы.
Пустой Vector — это маркер и нулевое число элементов, а не отсутствие данных.
Объект InputUser записывается со своим constructor ID; голого числового user_id недостаточно.
InputCheckPasswordSRP тоже boxed-объект со своей структурой, а не строка с паролем.
Для string и bytes используется TL-представление длины и выравнивание до четырёх байт; string дополнительно интерпретируется как текст.
Совпадение бинарной упаковки string/bytes не разрешает произвольно преобразовывать challenge или подпись в UTF-8.
В нашей проверке CRC используется нормализация bytes как string и разворачивание Vector<T> в форму Vector T.
Порядок полей запроса приведён отдельно у каждого метода; он проверяется по текущему сериализатору.
Не нужно дописывать constructor возвращаемого типа в конец тела запроса.

## Флаги
flags:# — обязательное 32-битное поле, когда оно указано в сигнатуре.
Запись password:flags.0?InputCheckPasswordSRP означает: поле присутствует только при установленном бите 0.
Значение nil/None и пустая строка или пустые bytes отличаются: пустое значение всё равно сериализуется, если бит включён.
Бит 0 соответствует маске 1; бит 1 — маске 2; бит 2 — маске 4.
В generated Swift-коде биты известных optional-полей пересчитываются из nil/non-nil аргументов.
Остальные переданные биты flags сохраняются; это техническая возможность сериализатора, не установленная семантика API.
В getTransactions и getUserAddresses flags есть, но в восстановленной сигнатуре нет conditional-полей.
Для getTransactions и getUserAddresses flags не сопровождаются conditional-полями в текущей сигнатуре; трактуем их как резерв/служебные биты и отправляем ноль.
Неизвестные биты по умолчанию следует оставлять нулевыми.
В toncenter.performApiRequest query использует бит 1, payload — бит 2; бит 0 не описан.
В tonConnectSubmitConnectResult trace_id использует бит 1, а в tonConnectSubmitResponse — бит 0.

## Повторы, таймауты и ошибки
Разрыв соединения после отправки мутации не доказывает, что сервер её не выполнил.
Для подписанного перевода отдельно хранится состояние «исход неизвестен»; создавать новую подпись только из-за таймаута неправильно.
Наличие random_id задаёт идентификатор операции; дедупликация предполагается рабочим сценарием, но срок и область действия сервером в TL не объявлены.
Повтор должен сохранять идентичность операции; новый random_id нельзя выдавать за повтор прежнего перевода.
Для create/replace/backup/claim/register/submit/close нужен отдельный сценарий reconciliation после неоднозначного результата.
Для чтений допустимость повтора проще, но частота запросов и FLOOD_WAIT остаются ограничениями.
Нельзя считать запрос read-only по префиксу get/next или по наличию Bool в ответе.
RPC 400 не является единым диагнозом: сериализация, доступность функции и состояние аккаунта — разные причины.
RPC 403 ACCESS_DENIED не доказывает отсутствие метода.
WALLET_UNAVAILABLE не доказывает правильность всех отправленных полей или доступность остальных wallet-операций.
INPUT_METHOD_INVALID может означать неподдерживаемый ID/контекст; ошибка не раскрывает полный серверный диспетчер.
Список ошибок ниже описывает известные случаи и общие классы, а не исчерпывающий официальный error catalog.

## Навигация по методам

1. [wallet.disableBackup](#method-1)
2. [wallet.enableBackup](#method-2)
3. [wallet.exportSecretPhrase](#method-3)
4. [wallet.fetchEncryptedSecretPhrasePart](#method-4)
5. [wallet.getBackupHolderDcs](#method-5)
6. [wallet.getExistingWaltBalance](#method-6)
7. [wallet.getGaslessInfo](#method-7)
8. [wallet.getProofChallenge](#method-8)
9. [wallet.getTransactions](#method-9)
10. [wallet.getTransactionsByIDs](#method-10)
11. [wallet.getTransactionsByMsgHash](#method-11)
12. [wallet.getUserAddresses](#method-12)
13. [wallet.replaceWallet](#method-13)
14. [wallet.sendTransfer](#method-14)
15. [wallet.tonConnectClaimRequest](#method-15)
16. [wallet.tonConnectCloseSession](#method-16)
17. [wallet.tonConnectCreateSession](#method-17)
18. [wallet.tonConnectGetPending](#method-18)
19. [wallet.tonConnectGetSessions](#method-19)
20. [wallet.tonConnectNextEventId](#method-20)
21. [wallet.tonConnectRegisterKey](#method-21)
22. [wallet.tonConnectSubmitConnectResult](#method-22)
23. [wallet.tonConnectSubmitResponse](#method-23)
24. [toncenter.performApiRequest](#method-24)
25. [toncenter.getStreamingUrl](#method-25)

---

<a id="method-1"></a>
## 1. wallet.disableBackup
Категория: mutation.
Constructor ID: 0x0b0bf0da.
TL: flags:# password:flags.0?InputCheckPasswordSRP new_public_key:flags.1?bytes proof:flags.2?WalletOwnershipProof = WalletState
Поля: password optional bit 0; new_public_key optional bit 1; proof optional bit 2.
Порядок сериализации: constructor, flags, password, new_public_key, proof.
Результат: WalletState.
Логика: По имени выключает backup текущего wallet и может одновременно принять новый публичный ключ с proof.
Сценарий: Получить SRP, при необходимости подписать proof, отправить, проверить returned state и только потом менять local backup status.
Ограничения: wire-поля известны; не установлены только допустимые комбинации флагов и backend-требования к proof/SRP.
Реализация: Typed.disableBackup возвращает WalletState; отдельный backup UI не подключён.
Ошибки/повторы: Не считать timeout отказом: операция могла примениться..

<a id="method-2"></a>
## 2. wallet.enableBackup
Категория: mutation.
Constructor ID: 0x81a2b0f3.
TL: flags:# parts:Vector<bytes> password:flags.0?InputCheckPasswordSRP
Поля: parts обязательный Vector; password optional bit 0.
Порядок сериализации: constructor, flags, vector constructor, count, parts, password.
Результат: WalletState.
Логика: Включает резервное хранение набора opaque parts.
Сценарий: Подготовить части, сериализовать даже пустой vector явно, отправить и атомарно сохранить state.
Ограничения: parts — именно Vector<bytes>; смысл каждой opaque-части, порядок частей и лимиты backup-сервера требуют runtime-проверки.
Реализация: Typed.enableBackup и transport.enableBackup используют WalletBackupCrypto для подготовки parts.
Ошибки/повторы: Retry после timeout требует reconciliation..

<a id="method-3"></a>
## 3. wallet.exportSecretPhrase
Категория: sensitive read.
Constructor ID: 0x9077c9ac.
TL: flags:# password:flags.0?InputCheckPasswordSRP
Поля: password optional bit 0.
Порядок сериализации: constructor, flags, password.
Результат: wallet.SecretPhraseParts.
Логика: Запрашивает token и material для восстановления секрета.
Сценарий: Только после явного действия и local auth; не записывать token/parts в логи.
Ограничения: ответ wallet.SecretPhraseParts содержит token:string и dcs:Vector<int>; элементы — номера DC, а не HolderDc или plaintext-фраза.
Реализация: Typed.exportSecretPhrase используется transport.exportBackupSecret для получения token и holder-list.
Ошибки/повторы: Массовый existence probe запрещён по смыслу операции..

<a id="method-4"></a>
## 4. wallet.fetchEncryptedSecretPhrasePart
Категория: sensitive read.
Constructor ID: 0xf53925cf.
TL: token:string public_key:bytes
Поля: token и public_key обязательны.
Порядок сериализации: constructor, token, public_key.
Результат: wallet.EncryptedSecretPhrasePart.
Логика: Получает зашифрованную часть backup по token и ключу holder.
Сценарий: Вызывать для holder DC после export; расшифровывать только подтверждённым локальным кодом.
Ограничения: ответ wire-типизирован как wallet.EncryptedSecretPhrasePart с data:bytes; алгоритм шифрования и способ сборки фразы — серверная криптографическая семантика.
Реализация: transport.exportBackupSecret запрашивает части по DC и вызывает decryptAndCombineEnvelopes.
Ошибки/повторы: Token может быть одноразовым или короткоживущим..

<a id="method-5"></a>
## 5. wallet.getBackupHolderDcs
Категория: read.
Constructor ID: 0xd179d494.
TL: = Vector<wallet.HolderDc>
Поля: нет аргументов.
Порядок сериализации: constructor.
Результат: Vector<wallet.HolderDc>.
Логика: Возвращает Vector<wallet.HolderDc> с DC и public keys holder-узлов для backup.
Сценарий: Использовать перед export/fetch, сопоставлять каждый holder с правильным ключом.
Ограничения: каждый элемент wire-типа wallet.HolderDc содержит dc:int и public_key:bytes; это metadata backup, не список Telegram address overrides.
Реализация: Typed.getBackupHolderDcs декодирует Vector<HolderDc>; enableBackup проверяет число и размеры ключей.
Ошибки/повторы: Пустой Vector допустим; это ещё не доказывает отсутствие wallet-состояния.

<a id="method-6"></a>
## 6. wallet.getExistingWaltBalance
Категория: read.
Constructor ID: 0x628746e3.
TL: = Bool
Поля: нет аргументов; WALT — точное имя метода.
Порядок сериализации: constructor.
Результат: Bool.
Логика: Проверяет наличие или баланс существующего wallet-состояния текущего аккаунта.
Сценарий: Вызвать до create/link и различать false от RPC ошибки.
Ограничения: Live corrected probe: WALLET_UNAVAILABLE, то есть method распознан, но wallet capability недоступна.
Реализация: serializer есть; отдельный UI call не подключён.
Ошибки/повторы: Не считать WALLET_UNAVAILABLE значением false..

<a id="method-7"></a>
## 7. wallet.getGaslessInfo
Категория: read/updates.
Constructor ID: 0x742df0a1.
TL: = Updates
Поля: нет аргументов.
Порядок сериализации: constructor.
Результат: Updates.
Логика: Получает параметры gasless relayer через updates.
Сценарий: Перед send проверить актуальные min_amount/reset_at и только затем формировать gasless payload.
Ограничения: Updates контейнер содержит typed updateWalletGaslessInfo#aeaf9e74 с полями reset_at:int, min_amount:long, relayer_address:string; серверные условия доступности проверяются отдельно.
Реализация: serializer есть; current send path не вызывает.
Ошибки/повторы: Live corrected probe: WALLET_UNAVAILABLE..

<a id="method-8"></a>
## 8. wallet.getProofChallenge
Категория: sensitive read.
Constructor ID: 0x2025e697.
TL: = wallet.ProofChallenge
Поля: нет аргументов.
Порядок сериализации: constructor.
Результат: wallet.ProofChallenge.
Логика: Выдаёт challenge для TON proof перед link wallet.
Сценарий: Проверить expires/domain, подписать payload локальным TON key и вызвать replaceWallet imported.
Ограничения: response 0x99e41707 содержит payload:string, expires:int, domain:string; тип payload подтверждён вызовом сериализатора строки.
Реализация: serializer и link flow есть; live probe дал WALLET_UNAVAILABLE.
Ошибки/повторы: Challenge нельзя повторно использовать после expiry..

<a id="method-9"></a>
## 9. wallet.getTransactions
Категория: read history.
Constructor ID: 0xa8830a83.
TL: flags:# offset:string limit:int
Поля: offset и limit обязательны; flags semantics не названы.
Порядок сериализации: constructor, flags, offset string, limit int.
Результат: wallet.Transactions.
Логика: Постранично возвращает wallet history.
Сценарий: Первая страница всё равно кодирует offset как пустую string; next_offset передаётся без изменения.
Ограничения: typed-ответ wallet.Transactions полностью описан ниже: balance:long, Vector<WalletTransaction>, optional next_offset:string, Vector<Chat>, Vector<User>.
Реализация: serializer есть; UI history использует wallet-engine path.
Ошибки/повторы: Старые INPUT_CONSTRUCTOR_INVALID относятся к неверному раннему ID..

<a id="method-10"></a>
## 10. wallet.getTransactionsByIDs
Категория: read history.
Constructor ID: 0x811ceab6.
TL: id:Vector<string>
Поля: id обязателен, включая пустой vector.
Порядок сериализации: constructor, vector, count, strings.
Результат: wallet.Transactions.
Логика: Ищет transactions по строковым IDs.
Сценарий: Использовать для точечного reconciliation; не подставлять peer ID, msg_id или random_id без доказанной связи.
Ограничения: Формат id и max count не объявлены.
Реализация: serializer есть; direct reconciliation не интегрирован.
Ошибки/повторы: ответ типизирован, но серверная duplicate policy не объявлена; повторять запрос с теми же ID.

<a id="method-11"></a>
## 11. wallet.getTransactionsByMsgHash
Категория: read history.
Constructor ID: 0xa6bb795d.
TL: msg_hash:Vector<string>
Поля: msg_hash обязателен.
Порядок сериализации: constructor, vector, count, strings.
Результат: wallet.Transactions.
Логика: Ищет историю по external/message hashes.
Сценарий: Сохранять message hash после отправки и polling делать этим методом до typed confirmation.
Ограничения: msg_hash — opaque string; base64/hex и нормализацию задаёт вызывающий протокол, TL их не различает.
Реализация: serializer есть; current receipt не использует этот API.
Ошибки/повторы: Пустой ответ может означать pending indexing..

<a id="method-12"></a>
## 12. wallet.getUserAddresses
Категория: read identity mapping.
Constructor ID: 0x5275dfdd.
TL: flags:# id:Vector<InputUser> addresses:Vector<string>
Поля: id и addresses обязательны; conditional-полей у flags нет, поэтому обычно отправляется 0.
Порядок сериализации: constructor, flags, vector InputUser, vector strings.
Результат: wallet.UserAddresses.
Логика: Сопоставляет Telegram users и TON addresses.
Сценарий: Разрешить username в InputUser с access_hash; передать оба вектора, включая пустой addresses.
Ограничения: ответ wallet.UserAddresses содержит addresses и users; WALLET_UNAVAILABLE не является пустым результатом.
Реализация: recipientAddress использует WalletMTProto.Typed.getUserAddresses и проверяет user_id.
Ошибки/повторы: Old d8c72eec test was actually replaceWallet and invalid..

<a id="method-13"></a>
## 13. wallet.replaceWallet
Категория: mutation/link/create.
Constructor ID: 0xd8c72eec.
TL: flags:# wallet:InputWalletReplacement password:flags.0?InputCheckPasswordSRP
Поля: wallet required; password optional bit 0.
Порядок сериализации: constructor, flags, replacement constructor/payload, password.
Результат: WalletState.
Логика: Регистрирует, создаёт или заменяет wallet association.
Сценарий: new constructor 0x63a440dc; imported current serializer 0x2959057c with public_key and proof.
Ограничения: OwnershipProof current 0x60bccb0d has timestamp:int and signature:bytes; response decoder checks state/public key.
Реализация: Current app uses imported after getProofChallenge; new semantics unverified; no mutation live test.
Ошибки/повторы: Не удалять local secret при link error; retry with new challenge..

<a id="method-14"></a>
## 14. wallet.sendTransfer
Категория: financial mutation.
Constructor ID: 0xd37d8fdb.
TL: flags:# data_normal:bytes data_gasless:flags.0?bytes random_id:long
Поля: data_normal and random_id mandatory; gasless optional bit 0.
Порядок сериализации: constructor, flags, data_normal, data_gasless, random_id.
Результат: Updates.
Логика: Отправляет prepared signed transfer через wallet backend.
Сценарий: Sign/persist operation, send, process updates, reconcile hash/transactions; same random_id for retry.
Ограничения: data_normal не optional; gasless должен соответствовать getGaslessInfo; random_id likely deduplicates.
Реализация: Serializer exists, but current app sends Toncenter JSON-RPC instead.
Ошибки/повторы: Unknown result must never cause new random transfer automatically..

<a id="method-15"></a>
## 15. wallet.tonConnectClaimRequest
Категория: TON Connect mutation.
Constructor ID: 0xd5a9848b.
TL: flags:# session_id:long msg_id:long app_request_id:long challenge_answer:flags.0?bytes
Поля: challenge_answer optional bit 0.
Порядок сериализации: constructor, flags, session_id, msg_id, app_request_id, answer.
Результат: Bool.
Логика: Claims/approves a pending TON Connect request.
Сценарий: Get pending, verify IDs/expiry, calculate answer, submit same identifier tuple.
Ограничения: challenge bytes opaque; this challenge differs from getProofChallenge.
Реализация: serializer exists; MTProto lifecycle not wired.
Ошибки/повторы: Bool means accepted by backend, not dApp completion..

<a id="method-16"></a>
## 16. wallet.tonConnectCloseSession
Категория: TON Connect mutation.
Constructor ID: 0x99c1ca3b.
TL: session_id:long body:bytes
Поля: session_id and body mandatory.
Порядок сериализации: constructor, session_id, body.
Результат: Bool.
Логика: Закрывает TON Connect session с protocol body.
Сценарий: Stop listeners, send close, remove local session after response.
Ограничения: body semantics/signature not exposed by TL.
Реализация: serializer exists; coordinator still bridge-based.
Ошибки/повторы: Не путать session close с MTProto disconnect..

<a id="method-17"></a>
## 17. wallet.tonConnectCreateSession
Категория: TON Connect mutation.
Constructor ID: 0xcc931046.
TL: dapp_client_id:string manifest_url:string
Поля: both strings mandatory.
Порядок сериализации: constructor, dapp_client_id, manifest_url.
Результат: TonConnectSession.
Логика: Создаёт server-side session для dApp manifest.
Сценарий: Validate manifest/origin, create, persist session by client ID.
Ограничения: typed-ответ TonConnectSession и его вложенные TonConnectManifest/поля перечислены ниже; отдельно не доказаны только серверные правила создания и повторного вызова.
Реализация: serializer exists; copied UI does not use MTProto call.
Ошибки/повторы: Repeat may create duplicate sessions..

<a id="method-18"></a>
## 18. wallet.tonConnectGetPending
Категория: TON Connect read.
Constructor ID: 0x11aee065.
TL: flags:# dapp_client_id:flags.0?string session_id:flags.1?long
Поля: bit 0 dapp_client_id; bit 1 session_id.
Порядок сериализации: constructor, flags, optional client, optional session.
Результат: wallet.TonConnectPending.
Логика: Получает pending requests globally or by filter.
Сценарий: Poll foreground, validate session/msg/expires, then claim/respond.
Ограничения: typed-ответ wallet.TonConnectPending состоит из session:TonConnectSession и Vector<TonConnectRequest>; точные поля обоих вложенных типов приведены ниже.
Реализация: serializer exists; live old errors not sufficient for semantic proof.
Ошибки/повторы: Не auto-claim pending without user approval..

<a id="method-19"></a>
## 19. wallet.tonConnectGetSessions
Категория: TON Connect read.
Constructor ID: 0xa7ffb56e.
TL: = wallet.TonConnectSessions
Поля: нет аргументов.
Порядок сериализации: constructor.
Результат: wallet.TonConnectSessions.
Логика: Возвращает active sessions для восстановления UI.
Сценарий: Load after account start and reconcile local sessions.
Ограничения: ответ подтверждён raw probe как constructor 0x0e1f6896 wallet.TonConnectSessions с sessions:Vector<TonConnectSession>.
Реализация: serializer exists; no MTProto UI integration.
Ошибки/повторы: Session existence does not mean pending request..

<a id="method-20"></a>
## 20. wallet.tonConnectNextEventId
Категория: TON Connect cursor.
Constructor ID: 0x775d7244.
TL: session_id:long
Поля: session_id mandatory.
Порядок сериализации: constructor, session_id.
Результат: TonConnectNextEventId (без namespace wallet в methods.tl).
Логика: Получает следующий event cursor.
Сценарий: Use atomically per session; do not mix with msg_id.
Ограничения: ответ wire-типизирован как wallet.TonConnectNextEventId с event_id:long; вызов может менять server-side cursor.
Реализация: serializer exists; live old probe gave INPUT_FETCH_ERROR.
Ошибки/повторы: Concurrent calls may advance cursor..

<a id="method-21"></a>
## 21. wallet.tonConnectRegisterKey
Категория: TON Connect handshake.
Constructor ID: 0x338bcf1c.
TL: session_id:long client_id:string
Поля: both mandatory.
Порядок сериализации: constructor, session_id, client_id.
Результат: wallet.TonConnectChallenge.
Логика: Регистрирует client key/id и returns challenge.
Сценарий: Create session, register key, sign challenge, submit connect result.
Ограничения: ответ wire-типизирован как wallet.TonConnectChallenge с challenge:bytes и event_id:long; client_id — обязательная строка, а его protocol-level identity задаёт TON Connect.
Реализация: serializer exists; coordinator not migrated.
Ошибки/повторы: Do not pass username or Telegram peer ID..

<a id="method-22"></a>
## 22. wallet.tonConnectSubmitConnectResult
Категория: TON Connect mutation.
Constructor ID: 0xc2c00779.
TL: flags:# session_id:long challenge_answer:bytes body:bytes trace_id:flags.1?string
Поля: trace_id optional bit 1; bit 0 unused.
Порядок сериализации: constructor, flags, session, answer, body, trace.
Результат: Bool.
Логика: Завершает handshake result.
Сценарий: Use challenge from registerKey, preserve session and protocol body, submit once/reconcile.
Ограничения: answer/body opaque and may include signatures; do not log.
Реализация: serializer exists; typed lifecycle missing.
Ошибки/повторы: Bool is backend acceptance, not external app completion..

<a id="method-23"></a>
## 23. wallet.tonConnectSubmitResponse
Категория: TON Connect mutation.
Constructor ID: 0x4528f33d.
TL: flags:# session_id:long msg_id:long body:bytes trace_id:flags.0?string
Поля: trace_id optional bit 0.
Порядок сериализации: constructor, flags, session, msg_id, body, trace.
Результат: Bool.
Логика: Отвечает на конкретный dApp message.
Сценарий: Use msg_id from pending request; body must be protocol response or rejection.
Ограничения: Do not use a new msg_id on retry unless protocol explicitly says so.
Реализация: serializer exists; bridge remains old.
Ошибки/повторы: Expired/closed/signature errors are expected classes..

<a id="method-24"></a>
## 24. toncenter.performApiRequest
Категория: provider bridge.
Constructor ID: 0x8d7bdd61.
TL: flags:# endpoint:string query:flags.1?string payload:flags.2?string
Поля: query bit 1; payload bit 2; bit 0 unused.
Порядок сериализации: constructor, flags, endpoint, query, payload.
Результат: toncenter.ApiResponse.
Логика: Проксирует Toncenter-like HTTP/JSON-RPC through MTProto.
Сценарий: Allowlist scheme/host/path, size and timeout; relay FILE_MIGRATE to authorized DC.
Ограничения: Current response parser checks 0xac8dfe19 then Api.DataJSON; live call FILE_MIGRATE_4 then ACCESS_DENIED.
Реализация: Current wallet engine uses this bridge; endpoint may be mutation, not automatically read-only.
Ошибки/повторы: RPC JSON errors and TL errors are separate layers..

<a id="method-25"></a>
## 25. toncenter.getStreamingUrl
Категория: provider read/capability.
Constructor ID: 0xcdaf63c7.
TL: = toncenter.StreamingUrl
Поля: нет аргументов.
Порядок сериализации: constructor.
Результат: toncenter.StreamingUrl.
Логика: Возвращает streaming URL and expiry.
Сценарий: Validate host/scheme/expiry, open only required stream, close on account switch.
Ограничения: Live corrected probe gave 403 ACCESS_DENIED: method recognized, capability denied.
Реализация: serializer exists; stream lifecycle absent.
Ошибки/повторы: Do not log tokenized URL..

## Response-типы и поля
WalletState: текущий Swift link decoder ожидает constructor 0x95c5346b и проверяет возвращённый public key.
WalletState может иметь непустое состояние кошелька или empty-состояние; старый ID 0x90c467d1 не считать подтверждённым.
WalletOwnershipProof: исправленный constructor 0x60bccb0d, timestamp:int, signature:bytes.
InputWalletReplacement.new: 0x63a440dc без payload.
InputWalletReplacement.imported: 0x2959057c, public_key:bytes, OwnershipProof.
wallet.ProofChallenge: constructor 0x99e41707; payload:string, expires:int, domain:string.
wallet.UserAddresses: response constructor 0x928e7b55; current parser reads vector WalletUserAddress and entities.
WalletUserAddress: current parser expects 0xa1b895e5, user_id:long, address:string, public_key:bytes.
toncenter.ApiResponse: response constructor 0xac8dfe19 and Api.DataJSON inside.
IDs и поля Transactions и TON Connect response constructors приведены в разделе «Уточнённая TL-модель ответов»; raw probe дополнительно подтвердил wallet.TonConnectSessions.
Старый Downloads wallet.tl содержал сдвинутые/неверные IDs и optional fields, поэтому не использовать его для генерации.
## Поля и типы, которые нельзя путать
Telegram peer ID — signed 64-bit identity внутри Telegram; он не является TON address.
Telegram InputUser содержит user_id и access_hash; username сначала разрешается через Telegram API.
TON address — строка с TON-форматом, её нельзя передавать вместо InputUser.
public_key кошелька — публичный ключ TON account; Telegram RSA server key имеет другое назначение.
WalletOwnershipProof.signature — подпись proof; это не auth_key и не SRP password proof.
InputCheckPasswordSRP — вычисленный SRP-объект из account.getPassword; plaintext 2FA password не сериализуется.
msg_id TON Connect — request/event identity; app_request_id — application request identity.
session_id TON Connect — server wallet session; MTProto session file и auth key к нему не относятся.
random_id sendTransfer — idempotency candidate; wallet-engine operationId — local journal identity.
message hash signed TON transfer — не Telegram message ID и не random_id.
expires:int может быть Unix timestamp, но единицы нужно подтвердить response/документацией.
balance:long/amount:long обычно nanograms в TON domain, но exact field units требуют type semantics.
## Бинарный wire-format
Метод начинается 4-байтным little-endian constructor ID.
flags:# всегда сериализуется 4-байтным integer сразу после ID.
vector#1cb5c415 затем содержит count:int и элементы.
Пустой vector: 15 c4 b5 1c 00 00 00 00 в little-endian byte stream.
TL string/bytes используют длину, содержимое и выравнивание до 4 bytes.
long занимает 8 bytes; int занимает 4 bytes.
Optional field присутствует только если соответствующий bit включён.
Optional поля записываются в порядке декларации, а не в порядке установки bits.
unknown flags не следует устанавливать в probe: текущий serializer очищает известные optional bits, остальные сохраняет.
Для getUserAddresses flags есть, но conditional field в TL не назван; оставлять flags=0.
Для getTransactions flags есть без conditional fields; не угадывать значения.
performApiRequest использует bit 1 для query и bit 2 для payload.
submitConnectResult использует bit 1 для trace_id.
submitResponse использует bit 0 для trace_id.
## Создание кошелька: new против imported
inputWalletNew содержит только constructor 0x63a440dc и не переносит public key в запросе.
Это выглядит как просьба backend создать новый wallet для текущего Telegram аккаунта.
inputWalletImported содержит публичный ключ и proof и подходит для локально созданного TON wallet.
Текущий iOS UI выбирает imported: Rust engine сначала создаёт локальную пару ключей.
Локальный create успешен до server link и не доказывает, что Telegram wallet создан.
Для new TL фиксирует только пустой inputWalletNew; место хранения и момент появления secret не являются полями этого запроса, поэтому ownership/recovery нужно подтвердить отдельным state/readback.
replaceWallet name означает замену/установку state, а не обязательно только create.
getExistingWaltBalance может быть предохранительной проверкой миграции старого state.
Проверять returned public_key против local descriptor.
Проверять address/network против local descriptor.
При mismatch считать link неуспешным и не удалять local wallet.
## Безопасная обработка ошибок
INPUT_METHOD_INVALID_*: проверить actual constructor ID, DC/build capability и invocation context.
INPUT_CONSTRUCTOR_INVALID_*: проверить вложенный constructor, vector marker и mandatory/optional field order.
INPUT_REQUEST_TOO_LONG: часто означает лишние bytes/vector/constructor в теле; не лечить увеличением лимита.
WALLET_UNAVAILABLE: method recognized, but wallet/account capability unavailable; не подменять Bool false.
ACCESS_DENIED: method/provider recognized, server policy or entitlement denied.
FILE_MIGRATE_n: повторить тот же serialized request через authorized DC n, если account worker pool доступен.
FLOOD_WAIT_n: уважать wait, не запускать параллельные probes.
PASSWORD_HASH_INVALID: заново получить account password parameters; не повторять plaintext.
SESSION_REVOKED/AUTH_KEY_UNREGISTERED: остановить wallet operations и потребовать повторную авторизацию.
Timeout after mutation: status unknown; сначала reconcile, затем retry with same idempotency identity.
Unknown response constructor: сохранить bounded raw buffer, не считать success.
## Read-only probe policy
Безопасная первая очередь: getProofChallenge, getUserAddresses, getTransactions, getTransactionsByIDs, getTransactionsByMsgHash.
getUserAddresses требует настоящего InputUser; для self нужен access_hash из авторизованного User.
Для пустого адресного списка передавать Vector<string> count=0.
Вторая очередь: getBackupHolderDcs, getExistingWaltBalance, getGaslessInfo, TON Connect list methods.
getGaslessInfo возвращает Updates и может менять локальный cache; логировать без raw sensitive fields.
getTransactions limit держать небольшим и проверять count/bytes before allocation.
Не вызывать exportSecretPhrase в автоматическом probe.
Не вызывать enableBackup/disableBackup/replaceWallet/sendTransfer.
Не вызывать TON Connect submit/claim/close на чужом или неизвестном session.
Не вызывать performApiRequest с mutation endpoint.
Логировать method, ID, response class, RPC code/text, elapsed; не логировать request bytes целиком.
## Mutation policy
enableBackup и disableBackup меняют backup state.
replaceWallet меняет account wallet association.
sendTransfer может переместить реальные средства.
TON Connect create/register/submit/claim/close меняют session/approval state.
performApiRequest классифицируется по endpoint, а не по имени метода.
Перед mutation UI должен показать account, destination, amount, network и irreversible warning.
После local signing signed bytes сохраняются в journal до отправки.
После отправки journal переводится в submitted или unknown.
Failed/rejected/cancelled не создают receipt как confirmed.
Submitted receipt должна явно отличаться от blockchain confirmed.
## Текущая реализация форка
TelegramWalletTransport вызывает wallet.getUserAddresses для recipient prefill.
TelegramWalletTransport вызывает getProofChallenge и replaceWallet imported при link.
TelegramWalletTransport вызывает performApiRequest для wallet-engine provider traffic.
Network.walletRelayRequest обрабатывает FILE_MIGRATE_n через authorized multiplexed worker.
WalletEngine HTTP host проверяет https, toncenter.com, request size, response size и timeout.
Unexpected Swift callback errors преобразуются в HttpHostError, чтобы UniFFI не завершал процесс Rust abort.
Wallet UI создаёт local archive и account-scoped protected secret store.
Money attachment использует recipient name и inline send form.
ton_usd_rate берётся из active AppConfiguration; missing/invalid rate скрывает USD.
Receipt card отправляется обычным Telegram image message after submitted/confirmed result.
Receipt card — client-generated media, не server-authenticated wallet message constructor.
Current send engine path ещё не вызывает wallet.sendTransfer.
Добавлены WalletMTProto.Typed и декодеры для 25 методов; транспорт переведён на typed ответы. TON Connect lifecycle в интерфейсе пока использует прежний bridge.
## Архитектура relay
wallet-engine видит WalletProviderTransport, а не Telegram Network напрямую.
TelegramWalletHTTPHost преобразует HTTP request в endpoint/query/payload.
TelegramWalletTransport превращает этот payload в toncenter.performApiRequest.
Network отправляет обычный request через account network.
При FILE_MIGRATE_n запрос передаётся в main worker указанного DC.
Raw response декодируется как toncenter.ApiResponse/DataJSON.
JSON provider error остаётся ошибкой provider layer, даже если MTProto RPC был успешен.
Cancellation должен завершить Swift continuation ровно один раз.
Дубликат request ID блокируется host registry.
Relay не должен принимать произвольный host/path без allowlist.
## TON Connect integration checklist
Добавить typed constructors TonConnectSession, TonConnectRequest, TonConnectManifest и pending result.
Добавить typed parser wallet.tonConnectGetSessions/getPending/nextEventId/registerKey.
Сопоставлять session ID с account-scoped local storage.
Проверять manifest URL и TLS host до показа пользователю.
Показывать dApp name/icon, permissions, amount and destination before approval.
Хранить challenge только до expires.
Сериализовать per-session operations to prevent event cursor races.
После submit проверять Bool и polling updates/pending state.
Close session only after stopping local event listeners.
Не принимать arbitrary body from dApp without protocol parser.
Не логировать challenge, body, signature or nonce.
## Backup integration checklist
Response decoders SecretPhraseParts, HolderDc и EncryptedSecretPhrasePart добавлены; требуется проверка реальными полными ответами.
Проверить actual constructor IDs against same macOS build before shipping.
Сделать secure memory lifetime for decrypted phrase.
Применять local biometric before export.
Показывать DC/part progress without exposing bytes.
Handle partial failure and retry token expiration.
Проверять public key fingerprint before decrypting a returned part.
Не отправлять backup parts через toncenter provider bridge.
Синхронизировать local backup state with returned WalletState.
Сохранять no plaintext phrase in archive, logs or crash diagnostics.
## Что означает текущая live evidence
getProofChallenge с корректным ID вернул RPC 400 WALLET_UNAVAILABLE.
getUserAddresses с InputUserSelf и двумя пустыми/валидными vectors вернул WALLET_UNAVAILABLE.
Эти ответы подтверждают распознавание wallet method layer, но не успешный wallet state.
toncenter.performApiRequest получил FILE_MIGRATE_4 на аккаунтном DC.
После корректного worker relay к DC4 provider вернул ACCESS_DENIED.
getStreamingUrl получил ACCESS_DENIED; это capability/policy result.
Мутации не запускались и funds не отправлялись.
Нельзя из этих ответов вывести, что все response constructors декодированы правильно.
Нельзя из WALLET_UNAVAILABLE вывести, что challenge/addresses поля неверны.
Нельзя из ACCESS_DENIED вывести, что provider endpoint не существует.
Для полноценной проверки нужен аккаунт с wallet capability и macOS/iOS runtime.
## Телефонные и DC-ограничения
Flash environment использует один DC: 2.
Flash endpoint в форке: 31.76.29.36:2398.
Flash использует custom RSA public key и exclusive datacenter address override.
Wallet relay provider FILE_MIGRATE относится к Telegram wallet provider request, а не к Flash host configuration.
Перенос authorization в другой DC не должен менять wallet request body.
Текущий endpoint/test results относятся к конкретному account и серверной capability.
Production/Test/Flash account records различаются environment attribute.
Не смешивать Toncenter provider DC migration и Flash account DC migration.
## Пример логического Telethon wrapper
Сначала описать functions в TL schema и сгенерировать типы.
Для raw verification можно отправить только исправленный read-only constructor.
Проверить request byte prefix against expected ID.
Вызвать client(functions.wallet.GetProofChallenge()) только после генерации правильного layer/types.
Для getUserAddresses построить InputUser через resolved Telegram User, а не int peer ID.
Передать id=[input_user] и addresses=[].
Catch PhoneMigrateError during auth and reconnect to indicated DC before tests.
Catch RPCError separately from serialization/parser exceptions.
Record type(error), error text, method name and elapsed time.
Never print session string, api_hash, proof, private key or raw secret bytes.
## Проверка CRC и исходников
methods.tl содержит исправленные function declarations.
WalletMTProto.swift generated from methods.tl contains the same 25 request IDs.
CRC check normalizes bytes as string for TL declaration verification.
Nested constructor IDs are not automatically function IDs.
method-evidence.json contains binary offsets and candidate constructor immediates.
Candidate IDs still require request serialization verification.
Old Downloads wallet.tl is retained only as extraction evidence.
Current Swift parser values have higher confidence than old unverified type declarations.
Any new field must be checked against binary instruction order and response bytes.
## Финальный вывод
В этом билде найдено 23 wallet.* и 2 toncenter.* функции.
Отдельного wallet.createWallet нет.
Создание нового server wallet представлено inputWalletNew внутри wallet.replaceWallet.
Локальное создание TON keypair и server registration через imported — разные шаги.
Самый важный recipient method — getUserAddresses с InputUser vector и обязательным addresses vector.
Самый опасный method — sendTransfer: signed bytes, gasless option и random_id.
Самые чувствительные методы — exportSecretPhrase, fetchEncryptedSecretPhrasePart и backup mutations.
Самая широкая поверхность — toncenter.performApiRequest.
TON Connect функции образуют session/challenge/pending/response state machine.
Текущий iOS fork реализует часть read/link/provider paths, но не все typed responses.
Этот документ отделяет известный wire-формат от ещё не доказанных server semantics и больше не помечает известные поля backup/TON Connect как неизвестные.

## Уточнённая TL-модель ответов backup и TON Connect

Этот раздел заменяет прежние формулировки «формат не подтверждён».
В responses.tl перенесены локальные объявления ответов; полнота вложенных типов backup/TON Connect ещё не проверена живыми ответами.
Клиентские XOR, envelope и шифрование описаны в разделе «Восстановленный алгоритм backup»; серверная совместимость остаётся непроверенной.
### Backup response-конструкторы

wallet.encryptedSecretPhrasePart#18e82537 data:bytes = wallet.EncryptedSecretPhrasePart;
wallet.holderDc#f9d612ef dc:int public_key:bytes = wallet.HolderDc;
wallet.proofChallenge#99e41707 payload:string expires:int domain:string = wallet.ProofChallenge;
wallet.secretPhraseParts#e6d0ef01 token:string dcs:Vector<int> = wallet.SecretPhraseParts;

walletOwnershipProof#60bccb0d timestamp:int signature:bytes = WalletOwnershipProof;
walletState#95c5346b flags:# address:string public_key:bytes balance:long = WalletState;
walletStateEmpty#9cb9b2ec flags:# = WalletState;
inputWalletNew#63a440dc = InputWalletReplacement;
inputWalletImported#2959057c public_key:bytes proof:WalletOwnershipProof = InputWalletReplacement;

Ответ wallet.exportSecretPhrase — token:string плюс dcs:Vector<int>; ключи holder-узлов возвращает отдельный getBackupHolderDcs.
Ответ wallet.fetchEncryptedSecretPhrasePart — один opaque data:bytes.
Ответы wallet.disableBackup, wallet.enableBackup и wallet.replaceWallet — WalletState.

### TON Connect response-конструкторы

tonConnectManifest#d0f263bc url:string name:string icon_url:string = TonConnectManifest;
tonConnectNextEventId#582464e3 event_id:long = TonConnectNextEventId;
tonConnectRequest#a281cb31 flags:# session_id:long msg_id:long body:bytes expires:int topic:flags.0?string trace_id:flags.1?string = TonConnectRequest;
tonConnectSession#126556c6 flags:# id:long dapp_client_id:string client_id:flags.3?string nonce:bytes manifest:flags.4?TonConnectManifest manifest_error:flags.5?int date:int = TonConnectSession;
wallet.tonConnectChallenge#4bc89693 challenge:bytes event_id:long = wallet.TonConnectChallenge;
wallet.tonConnectPending#85c0f124 session:TonConnectSession requests:Vector<TonConnectRequest> = wallet.TonConnectPending;
wallet.tonConnectSessions#0e1f6896 sessions:Vector<TonConnectSession> = wallet.TonConnectSessions;

#### Что подтверждено runtime-пробой

- `wallet.tonConnectGetSessions` с ID `0xa7ffb56e` распознан сервером.
- Ответ этой пробы имел constructor `0x0e1f6896` и `response_bytes=36`.
- `wallet.tonConnectGetPending` с ID `0x11aee065` распознан сервером.
- Неверный lookup для pending вернул `TONCONNECT_LOOKUP_INVALID`.
- `wallet.tonConnectNextEventId` с ID `0x775d7244` распознан сервером.
- Неизвестная session для него вернула `TONCONNECT_SESSION_NOT_FOUND`.
- Значит, эти ошибки относятся к typed TON Connect методам, а не к отсутствующему методу.

### Transactions response-конструкторы

walletTransactionPeerAddress#e16b5ce1 flags:# address:string domain:flags.0?string = WalletTransactionPeer;
walletTransactionPeerUser#f8e0aa1c flags:# user_id:long address:string domain:flags.0?string = WalletTransactionPeer;
walletTransactionPeerUnsupported#957b50fb = WalletTransactionPeer;
walletTransaction#1e109708 flags:# id:string amount:long fee:long date:int peer:flags.0?WalletTransactionPeer comment:flags.1?string tx_hash:flags.2?string = WalletTransaction;
wallet.transactions#4322d5a5 flags:# balance:long transactions:Vector<WalletTransaction> next_offset:flags.0?string chats:Vector<Chat> users:Vector<User> = wallet.Transactions;

У wallet.Transactions сначала читаются flags и balance, затем vector transactions.
После него читаются optional next_offset, vector chats и vector users.

### Остальные response-конструкторы

walletUserAddress#a1b895e5 user_id:long address:string public_key:bytes = WalletUserAddress;
wallet.userAddresses#928e7b55 addresses:Vector<WalletUserAddress> users:Vector<User> = wallet.UserAddresses;
toncenter.apiResponse#ac8dfe19 response:DataJSON = toncenter.ApiResponse;
toncenter.streamingUrl#19887601 url:string expires:int = toncenter.StreamingUrl;
updateWalletGaslessInfo#aeaf9e74 reset_at:int min_amount:long relayer_address:string = Update;
updateWalletState#9375341e state:WalletState = Update;
updateWalletTonConnectPendingDisconnect#39c67432 session_ids:Vector<long> = Update;
updateWalletTonConnectSession#74d8be99 session:TonConnectSession = Update;
updateSentWalletTransaction#686c85a6 transaction:WalletTransaction = Update;

Старые объявления `e1bb0d61`, `90c467d1`, `d08ce645`, `59c57278` и `c23727c9` из извлечённого Downloads-файла считать устаревшими.
Для текущего форка использовать исправленные IDs из `methods.tl` и этот раздел response-типов.
`wallet.getUserAddresses` возвращает адреса и Telegram entities в `wallet.UserAddresses`.
`wallet.getTransactions`, `getTransactionsByIDs` и `getTransactionsByMsgHash` возвращают один и тот же `wallet.Transactions`.
TON Connect session, request, challenge и pending — отдельные boxed-конструкторы.
Их bytes-поля нельзя декодировать как UTF-8 без протокольного подтверждения.
Открытые поля даты/ID/адреса можно читать напрямую после проверки constructor ID.

## Восстановленный алгоритм backup: macOS 12.10.283233

Источник — машинный код WalletBackupCrypto, а не вывод из имён MTProto-методов.
x86_64 slice SHA-256: `f4cbeb5f2d5a8c3cbf1b6af3dc2c0bccc775925af6ea46fb4794dfed43c2ad8b`.
Точка шифрования: `+[WalletBackupCrypto encryptSecret:holderPublicKeys:error:]`, VA `0x10415e791`.
Точка восстановления: `-[WalletBackupCryptoKeyPair decryptAndCombineEnvelopes:error:]`, VA `0x10415da4a`.
Адреса VA относятся к исходному x86_64-бинарнику до ASLR, а не к iOS-сборке.
Дизассемблированные участки сохранены в [evidence](evidence/backup-split-encrypt.asm).
Ниже алгоритм клиентской части; внутренняя реализация holder-серверов не извлечена.

### Разделение секрета на три части

Вход `S` — непустой массив байтов; функция проверяет `1 <= len(S) <= 0xffffff`.
На входе также требуется ровно три публичных ключа holder-узлов, каждый длиной 32 байта.
Генерируются два независимых случайных массива `A` и `B`, оба длиной `len(S)`.
Третья часть вычисляется побайтно: `C[i] = S[i] XOR A[i] XOR B[i]`.
Части отправляются в порядке `A`, `B`, `C`, соответствующем порядку holder public keys.
Восстановление: `S[i] = A[i] XOR B[i] XOR C[i]`; требуются все три части одинаковой длины.
Проверено: генерация `0x10415ea39`, XOR при разделении `0x10415eaff`, XOR восстановления `0x10415e4f7`.

### Открытый текст каждой части

Перед шифрованием часть `share` упаковывается как `LE32(0x8b90dd08) || TL_BYTES(share)`.
`TL_BYTES` использует один байт длины для 0…253 либо `0xfe` и три байта длины little-endian.
После содержимого добавляются нулевые байты до границы четырёх байт.
Запись magic видна в `0x10415eddd…0x10415ee15`; разбор — в `0x10415e099` и `0x10415e0c6`.
Восстановитель проверяет magic, непустую часть, длину, нулевой padding и отсутствие хвоста.
Это внутренний формат plaintext части, а не constructor ответа `wallet.EncryptedSecretPhrasePart`.
Название TL-конструктора для magic не восстановлено; идентификатор и framing установлены непосредственно.

### Шифрование и публичные ключи

Для каждой из трёх частей создаётся отдельная временная пара ключей.
Ключ holder импортируется из соответствующего 32-байтного элемента входного массива.
Вызывается ECDH с временным private key и public key holder.
Упакованная часть шифруется симметричным ключом, полученным из ECDH.
Выходной элемент `parts[i]`: `ephemeral_public_key[32] || encrypted_message`.
В этой функции при создании backup внешняя оболочка `0x1ea87158` не добавляется.
Последовательность вызовов: `0x10415ebdc` → `0x10415ecd6` → `0x10415ed25` → `0x10415ef7a`.

### Криптографический примитив и связь с библиотекой

Прямо в вызываемом коде присутствует строка `tde2e_encrypt_data` по VA `0x1054c69bc`.
Там же строка пути к `td/tde2e/td/e2e/MessageEncryption.cpp` по VA `0x1054c690a`.
Вызов из wallet идёт через `0x10438c880` к `0x104396d90` и функции шифрования сообщения.
Поэтому библиотечная связь подтверждается бинарником, хотя XOR и envelope реализованы в WalletBackupCrypto.
Формулы ниже сверены с локальными [Keys.cpp](../../third-party/td/td/tde2e/td/e2e/Keys.cpp) и [MessageEncryption.cpp](../../third-party/td/td/tde2e/td/e2e/MessageEncryption.cpp).
Это использование библиотечного криптопримитива; wallet backup не является протоколом звонков или TON Connect.
Совместимость восстановленной реализации с настоящим backup пока не проверена end-to-end.

### Получение симметричного ключа

Public keys представлены как Ed25519; для DH выполняется преобразование в X25519.
Из public key извлекается `y` без старшего sign-бита, затем `u = (1+y)/(1-y) mod (2^255-19)`.
Из 32-байтного private seed берётся `SHA512(seed)[0:32]`, затем применяется X25519 clamping.
Вычисляется `dh = X25519(converted_private, converted_public)`.
Симметричный secret: `HMAC-SHA512(key="tde2e_shared_secret", message=dh)[0:32]`.
Направление аргументов HMAC существенно: строка здесь является ключом.
Преобразование описано в [Ed25519.cpp](../../third-party/td/td/tdutils/td/utils/Ed25519.cpp); label `x25519 shared secret` также найден в бинарнике.

### Шифрование сообщения с частью

Пусть `M = LE32(0x8b90dd08) || TL_BYTES(share)` и `K` — ECDH-derived secret.
`n = ((len(M) + 31) & ~15) - len(M)`; создаётся случайный prefix длиной `n`, первый байт равен `n`.
`P = prefix || M`; длина `P` кратна 16, prefix имеет длину 16…31 байт.
`L = HMAC-SHA512(key=K, message="tde2e_encrypt_data")`; `Ke=L[0:32]`, `Km=L[32:64]`.
`msg_id = HMAC-SHA256(key=Km, message=P || LE32(0))[0:16]`; дополнительное authenticated data здесь пустое.
`H = HMAC-SHA512(key=Ke, message=msg_id)`; AES key — `H[0:32]`, IV — `H[32:48]`.
`encrypted_message = msg_id || AES-256-CBC(key, IV, P)`; PKCS#7 не добавляется.

### Восстановление и внешняя оболочка

Функция принимает ровно три envelope и использует private key своего WalletBackupCryptoKeyPair.
Допустимы либо три bare blob, либо три wrapped blob; смешивание отклоняется.
Wrapped формат: `LE32(0x1ea87158) || index:int32 || count:int32 || tag:int32 || TL_BYTES(blob)`.
Названия `index`, `count`, `tag` описательные; оригинальные имена полей не восстановлены.
Проверяются `count == 3`, уникальные индексы 0, 1, 2 и равенство `tag` у всех оболочек.
`tag` нельзя без доказательств называть timestamp, версией или checksum.
Оболочки упорядочиваются по индексу; bare blob используются в переданном порядке.

### Разбор blob и окончательное восстановление

Проверяется `len(blob) > 32` и кратность полной длины blob 16.
Первые 32 байта blob — public key отправителя; оставшиеся байты — encrypted_message.
Получатель выполняет ECDH своим временным private key с этим public key.
После AES-CBC decryption проверяется HMAC/msg_id; затем проверяется и удаляется prefix.
Далее разбираются magic `0x8b90dd08` и TL_BYTES каждой расшифрованной части.
Три части должны иметь одинаковую ненулевую длину; результат — их побайтный XOR.
Проверки wrapper и XOR видны в [backup-combine.asm](evidence/backup-combine.asm).

### Граница установленных фактов

Алгоритм принимает произвольные bytes секрета; кодирование mnemonic в эти bytes этой функцией не определяется.
Срок export-token, holder-side re-encryption и соответствие `tag` серверному состоянию здесь не восстановлены.
Публичный ключ запроса fetch используется для получения частей на export-keypair; holder key и export key — разные роли.
Точная серверная пересылка/перешифрование требует отдельной проверки, а не вывода из имён полей.
Наличие SRP в MTProto-запросе не означает, что пароль 2FA непосредственно является AES-ключом backup.
Новые backup-классы реализуют найденное клиентское разделение, шифрование и восстановление.
Они не объявляются протестированными на настоящем серверном backup до проверки полного цикла.

## Подключение восстановленных частей в Telegram-iOS-wallet

Типизированные методы: [WalletResponses.swift](../../submodules/TelegramApi/Sources/WalletResponses.swift), namespace `WalletMTProto.Typed`.
Бинарный разбор: [WalletResponseReader.swift](../../submodules/TelegramApi/Sources/WalletResponseReader.swift), включая проверку полного потребления ответа.
Схема ответов: [responses.tl](responses.tl); генератор: [generate-responses.py](../../tools/wallet/generate-responses.py).
Существующий transport использует typed getUserAddresses, getProofChallenge, replaceWallet и performApiRequest.
В [TelegramWalletTransport.swift](../../submodules/WalletUI/Sources/TelegramWalletTransport.swift) добавлены enableBackup(secret:password:) и exportBackupSecret(password:).
Экспорт получает части через авторизованные подключения к номерам DC из dcs:Vector<int> ответа exportSecretPhrase.
Алгоритм реализован в [WalletBackupCrypto.mm](../../third-party/td/TdBinding/Sources/WalletBackupCrypto.mm) и [WalletBackupFormat.h](../../third-party/td/TdBinding/Sources/WalletBackupFormat.h).

### Проверки и ограничения реализации

Тест framing/XOR выполнен с AddressSanitizer и UndefinedBehaviorSanitizer.
Проверены короткие/длинные TL_BYTES, усечённые сообщения, неправильный padding и лишние байты.
Проверены повторные индексы, несовпадающий tag, смешанные wrapped/bare части и неверное число частей.
Шифрование использует существующие key_from_ecdh/encrypt_message_for_one/decrypt_message_for_one библиотеки проекта.
Новые ключи освобождаются через key_destroy; временные открытые части затираются перед освобождением.
iOS-сборка и end-to-end backup на сервере в этой проверке не выполнялись.
Typed API не означает, что все его методы уже вызываются интерфейсом или что вложенные response-схемы прошли live-проверку.

### Исправления после сверки сериализаторов macOS

В `wallet.secretPhraseParts#e6d0ef01` поле `dcs` имеет тип `Vector<int>`, а не `Vector<wallet.HolderDc>`.
Цикл по адресу `0x1013f78e0` читает элементы с шагом 4; `0x1013f7969` записывает int32.
В `wallet.proofChallenge#99e41707` поле `payload` — строка: сериализатор `0x1013f7690` вызывает string writer `0x1014f4320`.
В `tonConnectSession#126556c6` поля `client_id`, `manifest`, `manifest_error` зависят от битов 3, 4 и 5 соответственно.
Проверки масок `0x08`, `0x10`, `0x20` расположены по адресам `0x1012b6e2b`, `0x1012b6eb1`, `0x1012b6fc9`.
Биты 0–2 session не описаны как дополнительные поля; их семантика этой сверкой не установлена.
У `tonConnectRequest#a281cb31` optional-строки используют биты 0 и 1; это отдельный конструктор.

Дизассемблирование backup-ответов: [response-backup.asm](evidence/response-backup.asm).
Дизассемблирование TON Connect request/session: [response-tonconnect.asm](evidence/response-tonconnect.asm).
Адреса относятся к x86_64 slice локального Telegram 12.10.283233, а не к iOS-бинарнику.
SHA256 исследованного slice: `f4cbeb5f2d5a8c3cbf1b6af3dc2c0bccc775925af6ea46fb4794dfed43c2ad8b`.
Исправления перенесены в `responses.tl`, сгенерированные Swift-декодеры и transport экспорта/ownership proof.
Строка и bytes имеют одинаковое TL framing, но строка дополнительно требует корректного UTF-8.
Замена HolderDc на int меняет разбор: в векторе DC нет constructor-id и public key на каждый элемент.
Неверные session flags сдвигали чтение последующих полей при наличии optional-значений.
Эти подтверждения описывают клиентский wire-формат; успешные ответы сервера и полный backup-цикл здесь не проверялись.
