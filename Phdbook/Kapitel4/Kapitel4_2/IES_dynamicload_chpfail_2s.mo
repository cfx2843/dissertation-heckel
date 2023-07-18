within Phdbook.Kapitel4.Kapitel4_2;
model IES_dynamicload_chpfail_2s
  extends IES_dynamicload_normal_2s(
    BooleanFault1(startTime=30000),
    BooleanFault2(startTime=35000),
    hotWaterStorage(V=0.01*ScaleFactor.k*2*3600/(hotWaterStorage.c_v*hotWaterStorage.rho*(90 - 60))),
    BooleanFault3(startTime=35000),
    BooleanFault4(startTime=35000));
end IES_dynamicload_chpfail_2s;
