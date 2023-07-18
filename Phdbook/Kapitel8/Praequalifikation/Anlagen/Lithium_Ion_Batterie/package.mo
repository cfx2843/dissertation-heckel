within Phdbook.Kapitel8.Praequalifikation.Anlagen;
package Lithium_Ion_Batterie
  replaceable model StorageModel = Phdbook.Kapitel8.Praequalifikation.Anlagen.Lithium_Ion_Batterie.GenericStorage constrainedby Phdbook.Kapitel8.Praequalifikation.Anlagen.Lithium_Ion_Batterie.GenericStorage_base
                                                                                                                                                            "Pick GenericStorage for a loss free storage and GenericStorageHyst for storage with losses"
                                                                                                                                                                                               annotation(choicesAllMatching=true);
end Lithium_Ion_Batterie;
