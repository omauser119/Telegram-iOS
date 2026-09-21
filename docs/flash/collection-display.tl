// Flash server extension: these IDs are fixed, do not regenerate via CRC32.
---types---
starGiftCollectionDisplayItem#60db9565 gift_id:long order:int size:int = StarGiftCollectionDisplayItem;
starGiftCollectionDisplaySettings#41455693 flags:# collection_id:int hidden:flags.0?true main_tab:flags.1?true filter_mask:int items:Vector<StarGiftCollectionDisplayItem> = StarGiftCollectionDisplaySettings;
payments.starGiftCollectionsDisplaySettingsNotModified#543daf4d = payments.StarGiftCollectionsDisplaySettings;
payments.starGiftCollectionsDisplaySettings#283973d1 settings:Vector<StarGiftCollectionDisplaySettings> hash:long = payments.StarGiftCollectionsDisplaySettings;
---functions---
payments.getStarGiftCollectionsDisplaySettings#df1cfd23 peer:InputPeer hash:long = payments.StarGiftCollectionsDisplaySettings;
payments.updateStarGiftCollectionDisplaySettings#8db0c705 flags:# peer:InputPeer collection_id:int hidden:flags.0?Bool main_tab:flags.1?Bool filter_mask:flags.2?int items:flags.3?Vector<StarGiftCollectionDisplayItem> = StarGiftCollectionDisplaySettings;
