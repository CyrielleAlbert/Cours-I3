"?c
DDeviceIDLE"IDLE1?????ƠBA?????ƠBQ      ??Y      ???Unknown
BHostIDLE"IDLE1ffffƀ?@Affffƀ?@ao?j9???io?j9????Unknown
uHostFlushSummaryWriter"FlushSummaryWriter(1???????@9???????@A???????@I???????@a-???N???i?6G?|???Unknown?
?HostConv2DBackpropFilter";gradient_tape/sequential/conv2d/Conv2D/Conv2DBackpropFilter(133333!?@933333!?@A33333!?@I33333!?@a*J?^Q??ibz?d2f???Unknown
sHost_FusedConv2D"sequential/conv2d/BiasAdd(1     ??@9     ??@A     ??@I     ??@a??CV??i̸?;???Unknown
?HostRandomUniform"7sequential/dropout/dropout/random_uniform/RandomUniform(1fffff??@9fffff??@Afffff??@Ifffff??@as]??"Ӭ?i????????Unknown
?HostBiasAddGrad"3gradient_tape/sequential/conv2d/BiasAdd/BiasAddGrad(1?????F?@9?????F?@A?????F?@I?????F?@a??X???iߑWvKs???Unknown
?HostMaxPoolGrad":gradient_tape/sequential/max_pooling2d/MaxPool/MaxPoolGrad(1     ȗ@9     ȗ@A     ȗ@I     ȗ@a(p??g??i?hř???Unknown
u	HostMaxPool" sequential/max_pooling2d/MaxPool(1     ??@9     ??@A     ??@I     ??@a?cp???ipI/?>???Unknown
q
HostCast"sequential/dropout/dropout/Cast(133333??@933333??@A33333??@I33333??@ak?&C????i??;䎤???Unknown
?HostSigmoidGrad"3gradient_tape/sequential/conv2d/Sigmoid/SigmoidGrad(133333[?@933333[?@A33333[?@I33333[?@a[wE?Q??is?L:?	???Unknown
yHostMatMul"%gradient_tape/sequential/dense/MatMul(133333?z@933333?z@A33333?z@I33333?z@a?0?gۄ?i4???@]???Unknown
{HostMatMul"'gradient_tape/sequential/dense/MatMul_1(133333sx@933333sx@A33333sx@I33333sx@a??????iLԏ9?????Unknown
?HostGreaterEqual"'sequential/dropout/dropout/GreaterEqual(1     ?r@9     ?r@A     ?r@I     ?r@a?
?Ԉ?|?ia?9K6????Unknown
oHostMul"sequential/dropout/dropout/Mul(1fffff&n@9fffff&n@Afffff&n@Ifffff&n@aD?eUw?i??w????Unknown
nHostSigmoid"sequential/conv2d/Sigmoid(1??????h@9??????h@A??????h@I??????h@aC?n?=s?i?U?\7???Unknown
rHost_FusedMatMul"sequential/dense/BiasAdd(1fffffF^@9fffffF^@AfffffF^@IfffffF^@a?
?
)ng?i?`??N???Unknown
^HostGatherV2"GatherV2(1?????,\@9?????,\@A?????,\@I?????,\@a???[?e?i?????d???Unknown
}HostMul",gradient_tape/sequential/dropout/dropout/Mul(1??????Q@9??????Q@A??????Q@I??????Q@a?u?qo[?i;r??Pr???Unknown
?HostResourceApplyAdam""Adam/Adam/update/ResourceApplyAdam(1??????L@9??????L@A??????L@I??????L@a>?~N"V?i?1??a}???Unknown
HostMul".gradient_tape/sequential/dropout/dropout/Mul_2(1??????E@9??????E@A??????E@I??????E@a?x?Q??P?i???Zօ???Unknown
`HostGatherV2"
GatherV2_1(1      E@9      E@A      E@I      E@a?/?ْ@P?iX?C??????Unknown
?HostResourceApplyAdam"$Adam/Adam/update_4/ResourceApplyAdam(133333?B@933333?B@A33333?B@I33333?B@a??????L?i~
i3????Unknown
?HostSelectV2"=gradient_tape/categorical_crossentropy/clip_by_value/SelectV2(1fffff?A@9fffff?A@Afffff?A@Ifffff?A@a	gZ?ɴK?ia?H ????Unknown
?HostResourceApplyAdam"$Adam/Adam/update_2/ResourceApplyAdam(1     ??@9     ??@A     ??@I     ??@aZǡF?`H?i?	?8????Unknown
?HostRealDiv"8gradient_tape/categorical_crossentropy/truediv/RealDiv_1(1ffffff>@9ffffff>@Affffff>@Iffffff>@a??????G?i??;????Unknown
qHostMul" sequential/dropout/dropout/Mul_1(1??????=@9??????=@A??????=@I??????=@a?n2wm?F?i??{Vԭ???Unknown
?HostDataset"5Iterator::Model::ParallelMapV2::Zip[1]::ForeverRepeat(1??????E@9??????E@A333333:@I333333:@a?I5??FD?iڠa
?????Unknown
?HostResourceApplyAdam"$Adam/Adam/update_3/ResourceApplyAdam(1??????8@9??????8@A??????8@I??????8@ax???	C?i?̇~?????Unknown
dHostDataset"Iterator::Model(133333?=@933333?=@A3333338@I3333338@a???ؐ?B?i ?"W????Unknown
}HostMatMul")gradient_tape/sequential/dense_1/MatMul_1(1     ?7@9     ?7@A     ?7@I     ?7@a??I?/B?i?@?????Unknown
? HostResourceApplyAdam"$Adam/Adam/update_5/ResourceApplyAdam(1     ?6@9     ?6@A     ?6@I     ?6@a?N??iA?iz???=????Unknown
t!Host_FusedMatMul"sequential/dense_1/BiasAdd(1fffff?5@9fffff?5@Afffff?5@Ifffff?5@aK?|I??@?i??Dz????Unknown
m"HostSum"categorical_crossentropy/Sum(1??????4@9??????4@A??????4@I??????4@a?i???@?i?gۀ?????Unknown
?#HostMinimum".categorical_crossentropy/clip_by_value/Minimum(1?????L4@9?????L4@A?????L4@I?????L4@a?????k??i^???m????Unknown
?$HostBiasAddGrad"2gradient_tape/sequential/dense/BiasAdd/BiasAddGrad(1fffff?3@9fffff?3@Afffff?3@Ifffff?3@a??)G?>?i?j??G????Unknown
?%HostDataset"AIterator::Model::ParallelMapV2::Zip[1]::ForeverRepeat::FromTensor(1      1@9      !@A      1@I      !@a?q??*P:?i'科????Unknown
?&HostResourceApplyAdam"$Adam/Adam/update_1/ResourceApplyAdam(1??????/@9??????/@A??????/@I??????/@aS*?6?t8?iM?m=?????Unknown
?'HostDataset"/Iterator::Model::ParallelMapV2::Zip[0]::FlatMap(1     ?4@9     ?4@A??????.@I??????.@a?׶,?7?i/??????Unknown
Z(HostArgMax"ArgMax(1??????-@9??????-@A??????-@I??????-@a?n2wm?6?i}??x????Unknown
u)HostRealDiv" categorical_crossentropy/truediv(1      &@9      &@A      &@I      &@aCu9?1?i????????Unknown
\*HostArgMax"ArgMax_1(1ffffff%@9ffffff%@Affffff%@Iffffff%@ar???ҏ0?ivN??????Unknown
i+HostWriteSummary"WriteSummary(1??????@9??????@A??????@I??????@aS*?6?t(?i?,2????Unknown?
?,HostSelectV2"?gradient_tape/categorical_crossentropy/clip_by_value/SelectV2_1(1333333@9333333@A333333@I333333@a?P?-?&?i'?쾛????Unknown
s-HostDataset"Iterator::Model::ParallelMapV2(1      @9      @A      @I      @aCu9?!?ix?*?????Unknown
?.HostDataset"?Iterator::Model::ParallelMapV2::Zip[0]::FlatMap[0]::TensorSlice(1ffffff@9ffffff@Affffff@Iffffff@a???sf??if3DŨ????Unknown
?/HostRealDiv"8gradient_tape/categorical_crossentropy/truediv/RealDiv_2(1      @9      @A      @I      @a??????i;?{l?????Unknown
{0HostMatMul"'gradient_tape/sequential/dense_1/MatMul(1??????@9??????@A??????@I??????@a??WtgV?i?v??????Unknown
?1HostMul"0gradient_tape/categorical_crossentropy/mul/Mul_1(1333333@9333333@A333333@I333333@aw??uj??i%h????Unknown
?2HostRealDiv"6gradient_tape/categorical_crossentropy/truediv/RealDiv(1ffffff@9ffffff@Affffff@Iffffff@a??>vkb?i?f.3????Unknown
x3HostDataset"#Iterator::Model::ParallelMapV2::Zip(1??????P@9??????P@A      @I      @a3?{????i???M?????Unknown
?4HostBiasAddGrad"4gradient_tape/sequential/dense_1/BiasAdd/BiasAddGrad(1333333@9333333@A333333@I333333@ar??vl%?i?@*y?????Unknown
5HostTile"-gradient_tape/categorical_crossentropy/Tile_1(1??????@9??????@A??????@I??????@a.Wo??I?i3???l????Unknown
m6HostLog"categorical_crossentropy/Log(1      @9      @A      @I      @a???????i?!`????Unknown
?7HostGreaterEqual"Agradient_tape/categorical_crossentropy/clip_by_value/GreaterEqual(1      @9      @A      @I      @a???????i?????????Unknown
[8HostAddV2"Adam/add(1ffffff@9ffffff@Affffff@Iffffff@a$?V??U?i?T9? ????Unknown
e9Host
LogicalAnd"
LogicalAnd(1ffffff@9ffffff@Affffff@Iffffff@a$?V??U?ii?V?????Unknown?
~:HostAssignAddVariableOp"Adam/Adam/AssignAddVariableOp(1??????@9??????@A??????@I??????@ac??yr??i?\1????Unknown
?;Host	LessEqual">gradient_tape/categorical_crossentropy/clip_by_value/LessEqual(1??????@9??????@A??????@I??????@ac??yr??i???Ͷ????Unknown
v<HostAssignAddVariableOp"AssignAddVariableOp_2(1??????@9??????@A??????@I??????@a?i????i$???7????Unknown
l=HostIteratorGetNext"IteratorGetNext(1??????@9??????@A??????@I??????@a?i????i?U ]?????Unknown
X>HostEqual"Equal(1      @9      @A      @I      @a??????i&?04????Unknown
b?HostDivNoNan"div_no_nan_1(1      @9      @A      @I      @a??????i}?W?????Unknown
{@HostMaximum"&categorical_crossentropy/clip_by_value(1333333@9333333@A333333@I333333@a=t?????i????&????Unknown
tAHostReadVariableOp"Adam/Cast/ReadVariableOp(1ffffff@9ffffff@Affffff@Iffffff@a?D??z?i??Ϙ????Unknown
oBHostSum"categorical_crossentropy/Sum_1(1ffffff@9ffffff@Affffff@Iffffff@a?D??z?iAq??
????Unknown
?CHostNeg"2gradient_tape/categorical_crossentropy/truediv/Neg(1??????@9??????@A??????@I??????@a9???=?iaG??w????Unknown
VDHostSum"Sum_2(1?????? @9?????? @A?????? @I?????? @a???? 
?ii???????Unknown
?EHostReadVariableOp"(sequential/conv2d/BiasAdd/ReadVariableOp(1?????? @9?????? @A?????? @I?????? @a???? 
?iq?>?G????Unknown
mFHostSigmoid"sequential/dense/Sigmoid(1?????? @9?????? @A?????? @I?????? @a???? 
?iy?꽯????Unknown
vGHostReadVariableOp"Adam/Cast_2/ReadVariableOp(1       @9       @A       @I       @a3?{????ih???????Unknown
[HHostPow"
Adam/Pow_1(1ffffff??9ffffff??Affffff??Iffffff??a???????i>?N?p????Unknown
VIHostAddN"AddN(1ffffff??9ffffff??Affffff??Iffffff??a???????ia?????Unknown
`JHostDivNoNan"
div_no_nan(1ffffff??9ffffff??Affffff??Iffffff??a???????i?<? -????Unknown
?KHostSum"4gradient_tape/categorical_crossentropy/truediv/Sum_1(1ffffff??9ffffff??Affffff??Iffffff??a???????i?j<?????Unknown
?LHostReadVariableOp"'sequential/conv2d/Conv2D/ReadVariableOp(1333333??9333333??A333333??I333333??a?'????ie?%p?????Unknown
?MHostReadVariableOp"&sequential/dense/MatMul/ReadVariableOp(1????????9????????A????????I????????a)?b????i????.????Unknown
vNHostAssignAddVariableOp"AssignAddVariableOp_4(1      ??9      ??A      ??I      ??a???????id???x????Unknown
wOHostReadVariableOp"div_no_nan_1/ReadVariableOp(1      ??9      ??A      ??I      ??a???????iנmG?????Unknown
?PHost
Reciprocal"1gradient_tape/categorical_crossentropy/Reciprocal(1      ??9      ??A      ??I      ??a???????iJ?1?????Unknown
]QHostCast"Adam/Cast_1(1ffffff??9ffffff??Affffff??Iffffff??a$?V??U?i?i??R????Unknown
vRHostReadVariableOp"Adam/Cast_3/ReadVariableOp(1ffffff??9ffffff??Affffff??Iffffff??a$?V??U?i?N?B?????Unknown
YSHostPow"Adam/Pow(1ffffff??9ffffff??Affffff??Iffffff??a$?V??U?iX4???????Unknown
uTHostReadVariableOp"div_no_nan/ReadVariableOp(1ffffff??9ffffff??Affffff??Iffffff??a$?V??U?i?Q?"????Unknown
oUHostSigmoid"sequential/dense_1/Sigmoid(1????????9????????A????????I????????a?i??? ?i? Vc????Unknown
XVHostCast"Cast_1(1333333??9333333??A333333??I333333??a=t?????>i??Ş????Unknown
{WHostMul"*gradient_tape/categorical_crossentropy/mul(1333333??9333333??A333333??I333333??a=t?????>iFӼ5?????Unknown
vXHostAssignAddVariableOp"AssignAddVariableOp_3(1????????9????????A????????I????????a.Wo??I?>i%?????Unknown
mYHostMul"categorical_crossentropy/mul(1????????9????????A????????I????????a.Wo??I?>i?t]3????Unknown
?ZHostMul"2gradient_tape/categorical_crossentropy/truediv/mul(1????????9????????A????????I????????a.Wo??I?>i??P?_????Unknown
?[HostSigmoidGrad"2gradient_tape/sequential/dense/Sigmoid/SigmoidGrad(1????????9????????A????????I????????a)?b????>i??0??????Unknown
?\HostSigmoidGrad"4gradient_tape/sequential/dense_1/Sigmoid/SigmoidGrad(1????????9????????A????????I????????a)?b????>io?1?????Unknown
t]HostAssignAddVariableOp"AssignAddVariableOp(1ffffff??9ffffff??Affffff??Iffffff??a$?V??U?>it???????Unknown
?^HostReadVariableOp"'sequential/dense/BiasAdd/ReadVariableOp(1ffffff??9ffffff??Affffff??Iffffff??a$?V??U?>i?f؈?????Unknown
v_HostAssignAddVariableOp"AssignAddVariableOp_1(1333333??9333333??A333333??I333333??a=t?????>i][?@????Unknown
{`HostSum"*categorical_crossentropy/weighted_loss/Sum(1333333??9333333??A333333??I333333??a=t?????>i?O??/????Unknown
?aHostDivNoNan",categorical_crossentropy/weighted_loss/value(1333333??9333333??A333333??I333333??a=t?????>i?D??M????Unknown
?bHostReadVariableOp")sequential/dense_1/BiasAdd/ReadVariableOp(1333333??9333333??A333333??I333333??a=t?????>i9xhk????Unknown
ocHostReadVariableOp"Adam/ReadVariableOp(1      ??9      ??A      ??I      ??a3?{????>i?/d,?????Unknown
?dHostReadVariableOp"(sequential/dense_1/MatMul/ReadVariableOp(1      ??9      ??A      ??I      ??a3?{????>i&P??????Unknown
aeHostIdentity"Identity(1????????9????????A????????I????????a)?b????>it@??????Unknown?
TfHostMul"Mul(1????????9????????A????????I????????a)?b????>i?0??????Unknown
mgHostNeg"categorical_crossentropy/Neg(1????????9????????A????????I????????a)?b????>i: `?????Unknown
whHostReadVariableOp"div_no_nan/ReadVariableOp_1(1????????9????????A????????I????????a)?b????>i?0?????Unknown
yiHostReadVariableOp"div_no_nan_1/ReadVariableOp_1(1????????9????????A????????I????????a)?b????>i      ???Unknown*?b
uHostFlushSummaryWriter"FlushSummaryWriter(1???????@9???????@A???????@I???????@a?)m?????i?)m??????Unknown?
?HostConv2DBackpropFilter";gradient_tape/sequential/conv2d/Conv2D/Conv2DBackpropFilter(133333!?@933333!?@A33333!?@I33333!?@a?l??c ??i?"u????Unknown
sHost_FusedConv2D"sequential/conv2d/BiasAdd(1     ??@9     ??@A     ??@I     ??@a??~u??i2??@ɗ???Unknown
?HostRandomUniform"7sequential/dropout/dropout/random_uniform/RandomUniform(1fffff??@9fffff??@Afffff??@Ifffff??@a:????ii ?*???Unknown
?HostBiasAddGrad"3gradient_tape/sequential/conv2d/BiasAdd/BiasAddGrad(1?????F?@9?????F?@A?????F?@I?????F?@a?ṃ?x??i????????Unknown
?HostMaxPoolGrad":gradient_tape/sequential/max_pooling2d/MaxPool/MaxPoolGrad(1     ȗ@9     ȗ@A     ȗ@I     ȗ@a˫???@??iI?08?A???Unknown
uHostMaxPool" sequential/max_pooling2d/MaxPool(1     ??@9     ??@A     ??@I     ??@a`W,?N]??i???"?????Unknown
qHostCast"sequential/dropout/dropout/Cast(133333??@933333??@A33333??@I33333??@a?˦??k??i?(?S???Unknown
?	HostSigmoidGrad"3gradient_tape/sequential/conv2d/Sigmoid/SigmoidGrad(133333[?@933333[?@A33333[?@I33333[?@a?RXF???i??[4????Unknown
y
HostMatMul"%gradient_tape/sequential/dense/MatMul(133333?z@933333?z@A33333?z@I33333?z@aN^?????i?-A?`????Unknown
{HostMatMul"'gradient_tape/sequential/dense/MatMul_1(133333sx@933333sx@A33333sx@I33333sx@aR½YĒ?i????W???Unknown
?HostGreaterEqual"'sequential/dropout/dropout/GreaterEqual(1     ?r@9     ?r@A     ?r@I     ?r@a?u9bf??i??$?????Unknown
oHostMul"sequential/dropout/dropout/Mul(1fffff&n@9fffff&n@Afffff&n@Ifffff&n@a??AVa$??i??}Į%???Unknown
nHostSigmoid"sequential/conv2d/Sigmoid(1??????h@9??????h@A??????h@I??????h@au)1g??i??Bar???Unknown
rHost_FusedMatMul"sequential/dense/BiasAdd(1fffffF^@9fffffF^@AfffffF^@IfffffF^@a?z?<?<w?i???C~????Unknown
^HostGatherV2"GatherV2(1?????,\@9?????,\@A?????,\@I?????,\@a#???L?u?i??ܾ????Unknown
}HostMul",gradient_tape/sequential/dropout/dropout/Mul(1??????Q@9??????Q@A??????Q@I??????Q@a?p?E?5k?i(???????Unknown
?HostResourceApplyAdam""Adam/Adam/update/ResourceApplyAdam(1??????L@9??????L@A??????L@I??????L@a?^ab??e?i?q|?????Unknown
HostMul".gradient_tape/sequential/dropout/dropout/Mul_2(1??????E@9??????E@A??????E@I??????E@a????t?`?iAB?????Unknown
`HostGatherV2"
GatherV2_1(1      E@9      E@A      E@I      E@aC?o`?i_?[`????Unknown
?HostResourceApplyAdam"$Adam/Adam/update_4/ResourceApplyAdam(133333?B@933333?B@A33333?B@I33333?B@a?????\?i??&,???Unknown
?HostSelectV2"=gradient_tape/categorical_crossentropy/clip_by_value/SelectV2(1fffff?A@9fffff?A@Afffff?A@Ifffff?A@a???c?z[?i??M)?9???Unknown
?HostResourceApplyAdam"$Adam/Adam/update_2/ResourceApplyAdam(1     ??@9     ??@A     ??@I     ??@ae????-X?i?A???E???Unknown
?HostRealDiv"8gradient_tape/categorical_crossentropy/truediv/RealDiv_1(1ffffff>@9ffffff>@Affffff>@Iffffff>@a\?"?UW?i	?2??Q???Unknown
qHostMul" sequential/dropout/dropout/Mul_1(1??????=@9??????=@A??????=@I??????=@a??]?N?V?i??|?]???Unknown
?HostDataset"5Iterator::Model::ParallelMapV2::Zip[1]::ForeverRepeat(1??????E@9??????E@A333333:@I333333:@a?/7?7T?iplX g???Unknown
?HostResourceApplyAdam"$Adam/Adam/update_3/ResourceApplyAdam(1??????8@9??????8@A??????8@I??????8@aHep???R?i?????p???Unknown
dHostDataset"Iterator::Model(133333?=@933333?=@A3333338@I3333338@a??>S9?R?i?CO??y???Unknown
}HostMatMul")gradient_tape/sequential/dense_1/MatMul_1(1     ?7@9     ?7@A     ?7@I     ?7@a????	R?iٗ?\ς???Unknown
?HostResourceApplyAdam"$Adam/Adam/update_5/ResourceApplyAdam(1     ?6@9     ?6@A     ?6@I     ?6@a?{??-EQ?i????q????Unknown
tHost_FusedMatMul"sequential/dense_1/BiasAdd(1fffff?5@9fffff?5@Afffff?5@Ifffff?5@a???G?P?i?ɗٓ???Unknown
m HostSum"categorical_crossentropy/Sum(1??????4@9??????4@A??????4@I??????4@a??0?D?O?i1?)՛???Unknown
?!HostMinimum".categorical_crossentropy/clip_by_value/Minimum(1?????L4@9?????L4@A?????L4@I?????L4@a?K4??)O?iDws??????Unknown
?"HostBiasAddGrad"2gradient_tape/sequential/dense/BiasAdd/BiasAddGrad(1fffff?3@9fffff?3@Afffff?3@Ifffff?3@au??+??N?i~k>?B????Unknown
?#HostDataset"AIterator::Model::ParallelMapV2::Zip[1]::ForeverRepeat::FromTensor(1      1@9      !@A      1@I      !@aaI???J?i?Kg?ȱ???Unknown
?$HostResourceApplyAdam"$Adam/Adam/update_1/ResourceApplyAdam(1??????/@9??????/@A??????/@I??????/@a	V?LAH?ia?Kٷ???Unknown
?%HostDataset"/Iterator::Model::ParallelMapV2::Zip[0]::FlatMap(1     ?4@9     ?4@A??????.@I??????.@a???i?G?i???R½???Unknown
Z&HostArgMax"ArgMax(1??????-@9??????-@A??????-@I??????-@a??]?N?F?i+??ep????Unknown
u'HostRealDiv" categorical_crossentropy/truediv(1      &@9      &@A      &@I      &@a?\?K??@?i??w!?????Unknown
\(HostArgMax"ArgMax_1(1ffffff%@9ffffff%@Affffff%@Iffffff%@a???`m@?i6?c?????Unknown
i)HostWriteSummary"WriteSummary(1??????@9??????@A??????@I??????@a	V?LA8?i?#/??????Unknown?
?*HostSelectV2"?gradient_tape/categorical_crossentropy/clip_by_value/SelectV2_1(1333333@9333333@A333333@I333333@a??+M?i6?iv??Ù????Unknown
s+HostDataset"Iterator::Model::ParallelMapV2(1      @9      @A      @I      @a?\?K??0?i"??!?????Unknown
?,HostDataset"?Iterator::Model::ParallelMapV2::Zip[0]::FlatMap[0]::TensorSlice(1ffffff@9ffffff@Affffff@Iffffff@a?$?]Q/?i??2?????Unknown
?-HostRealDiv"8gradient_tape/categorical_crossentropy/truediv/RealDiv_2(1      @9      @A      @I      @a??i?߳.?i??p?????Unknown
{.HostMatMul"'gradient_tape/sequential/dense_1/MatMul(1??????@9??????@A??????@I??????@a?ZA?.?i?"??w????Unknown
?/HostMul"0gradient_tape/categorical_crossentropy/mul/Mul_1(1333333@9333333@A333333@I333333@a????}g*?i?wS????Unknown
?0HostRealDiv"6gradient_tape/categorical_crossentropy/truediv/RealDiv(1ffffff@9ffffff@Affffff@Iffffff@a?1??-)?iɬ%?????Unknown
x1HostDataset"#Iterator::Model::ParallelMapV2::Zip(1??????P@9??????P@A      @I      @a?̇???(?iF?h#:????Unknown
?2HostBiasAddGrad"4gradient_tape/sequential/dense_1/BiasAdd/BiasAddGrad(1333333@9333333@A333333@I333333@azg$???'?i???N?????Unknown
3HostTile"-gradient_tape/categorical_crossentropy/Tile_1(1??????@9??????@A??????@I??????@a"8?&?i0d ????Unknown
m4HostLog"categorical_crossentropy/Log(1      @9      @A      @I      @aq٥??k"?i?/?A????Unknown
?5HostGreaterEqual"Agradient_tape/categorical_crossentropy/clip_by_value/GreaterEqual(1      @9      @A      @I      @aq٥??k"?i??}h????Unknown
[6HostAddV2"Adam/add(1ffffff@9ffffff@Affffff@Iffffff@a6ߒ?1!?i?9s?{????Unknown
e7Host
LogicalAnd"
LogicalAnd(1ffffff@9ffffff@Affffff@Iffffff@a6ߒ?1!?i?g쮎????Unknown?
~8HostAssignAddVariableOp"Adam/Adam/AssignAddVariableOp(1??????@9??????@A??????@I??????@a?{U? ?i??<??????Unknown
?9Host	LessEqual">gradient_tape/categorical_crossentropy/clip_by_value/LessEqual(1??????@9??????@A??????@I??????@a?{U? ?iD??9?????Unknown
v:HostAssignAddVariableOp"AssignAddVariableOp_2(1??????@9??????@A??????@I??????@a??0?D??i?X???????Unknown
l;HostIteratorGetNext"IteratorGetNext(1??????@9??????@A??????@I??????@a??0?D??iL???????Unknown
X<HostEqual"Equal(1      @9      @A      @I      @a??i?߳?i?5ڼ?????Unknown
b=HostDivNoNan"div_no_nan_1(1      @9      @A      @I      @a??i?߳?i???[?????Unknown
{>HostMaximum"&categorical_crossentropy/clip_by_value(1333333@9333333@A333333@I333333@a????zy?i F?'w????Unknown
t?HostReadVariableOp"Adam/Cast/ReadVariableOp(1ffffff@9ffffff@Affffff@Iffffff@aG+ܕ??i??Z Y????Unknown
o@HostSum"categorical_crossentropy/Sum_1(1ffffff@9ffffff@Affffff@Iffffff@aG+ܕ??i£;????Unknown
?AHostNeg"2gradient_tape/categorical_crossentropy/truediv/Neg(1??????@9??????@A??????@I??????@aay??iml?>????Unknown
VBHostSum"Sum_2(1?????? @9?????? @A?????? @I?????? @aҖN\K??i?N???????Unknown
?CHostReadVariableOp"(sequential/conv2d/BiasAdd/ReadVariableOp(1?????? @9?????? @A?????? @I?????? @aҖN\K??iW1A??????Unknown
mDHostSigmoid"sequential/dense/Sigmoid(1?????? @9?????? @A?????? @I?????? @aҖN\K??i??5~????Unknown
vEHostReadVariableOp"Adam/Cast_2/ReadVariableOp(1       @9       @A       @I       @a?̇????i
δB????Unknown
[FHostPow"
Adam/Pow_1(1ffffff??9ffffff??Affffff??Iffffff??a\?"?U?i&?`?????Unknown
VGHostAddN"AddN(1ffffff??9ffffff??Affffff??Iffffff??a\?"?U?i<??????Unknown
`HHostDivNoNan"
div_no_nan(1ffffff??9ffffff??Affffff??Iffffff??a\?"?U?i"R??r????Unknown
?IHostSum"4gradient_tape/categorical_crossentropy/truediv/Sum_1(1ffffff??9ffffff??Affffff??Iffffff??a\?"?U?i*h?d-????Unknown
?JHostReadVariableOp"'sequential/conv2d/Conv2D/ReadVariableOp(1333333??9333333??A333333??I333333??a?m3????iű?j?????Unknown
?KHostReadVariableOp"&sequential/dense/MatMul/ReadVariableOp(1????????9????????A????????I????????a??l?Q??i*8?q????Unknown
vLHostAssignAddVariableOp"AssignAddVariableOp_4(1      ??9      ??A      ??I      ??aq٥??k?iY???????Unknown
wMHostReadVariableOp"div_no_nan_1/ReadVariableOp(1      ??9      ??A      ??I      ??aq٥??k?i?\?????Unknown
?NHost
Reciprocal"1gradient_tape/categorical_crossentropy/Reciprocal(1      ??9      ??A      ??I      ??aq٥??k?i??h?+????Unknown
]OHostCast"Adam/Cast_1(1ffffff??9ffffff??Affffff??Iffffff??a6ߒ?1?i?#?G?????Unknown
vPHostReadVariableOp"Adam/Cast_3/ReadVariableOp(1ffffff??9ffffff??Affffff??Iffffff??a6ߒ?1?i????>????Unknown
YQHostPow"Adam/Pow(1ffffff??9ffffff??Affffff??Iffffff??a6ߒ?1?i?Q`?????Unknown
uRHostReadVariableOp"div_no_nan/ReadVariableOp(1ffffff??9ffffff??Affffff??Iffffff??a6ߒ?1?i??Z?Q????Unknown
oSHostSigmoid"sequential/dense_1/Sigmoid(1????????9????????A????????I????????a??0?D??iY?n??????Unknown
XTHostCast"Cast_1(1333333??9333333??A333333??I333333??a????zy?i?cY?G????Unknown
{UHostMul"*gradient_tape/categorical_crossentropy/mul(1333333??9333333??A333333??I333333??a????zy?iq.Dq?????Unknown
vVHostAssignAddVariableOp"AssignAddVariableOp_3(1????????9????????A????????I????????a"8??iZF??????Unknown
mWHostMul"categorical_crossentropy/mul(1????????9????????A????????I????????a"8??iC^$Jn????Unknown
?XHostMul"2gradient_tape/categorical_crossentropy/truediv/mul(1????????9????????A????????I????????a"8??i,v???????Unknown
?YHostSigmoidGrad"2gradient_tape/sequential/dense/Sigmoid/SigmoidGrad(1????????9????????A????????I????????a??l?Q??iߧ?O????Unknown
?ZHostSigmoidGrad"4gradient_tape/sequential/dense_1/Sigmoid/SigmoidGrad(1????????9????????A????????I????????a??l?Q??i??"?c????Unknown
t[HostAssignAddVariableOp"AssignAddVariableOp(1ffffff??9ffffff??Affffff??Iffffff??a6ߒ?1?i%A??????Unknown
?\HostReadVariableOp"'sequential/dense/BiasAdd/ReadVariableOp(1ffffff??9ffffff??Affffff??Iffffff??a6ߒ?1?i?p_u?????Unknown
v]HostAssignAddVariableOp"AssignAddVariableOp_1(1333333??9333333??A333333??I333333??a????zy?>i??Th(????Unknown
{^HostSum"*categorical_crossentropy/weighted_loss/Sum(1333333??9333333??A333333??I333333??a????zy?>i;J[c????Unknown
?_HostDivNoNan",categorical_crossentropy/weighted_loss/value(1333333??9333333??A333333??I333333??a????zy?>i\??N?????Unknown
?`HostReadVariableOp")sequential/dense_1/BiasAdd/ReadVariableOp(1333333??9333333??A333333??I333333??a????zy?>i?5A?????Unknown
oaHostReadVariableOp"Adam/ReadVariableOp(1      ??9      ??A      ??I      ??a?̇????>i??a
????Unknown
?bHostReadVariableOp"(sequential/dense_1/MatMul/ReadVariableOp(1      ??9      ??A      ??I      ??a?̇????>i?΀;????Unknown
acHostIdentity"Identity(1????????9????????A????????I????????a??l?Q??>i??q?b????Unknown?
TdHostMul"Mul(1????????9????????A????????I????????a??l?Q??>it5?????Unknown
meHostNeg"categorical_crossentropy/Neg(1????????9????????A????????I????????a??l?Q??>iMθf?????Unknown
wfHostReadVariableOp"div_no_nan/ReadVariableOp_1(1????????9????????A????????I????????a??l?Q??>i&g\??????Unknown
ygHostReadVariableOp"div_no_nan_1/ReadVariableOp_1(1????????9????????A????????I????????a??l?Q??>i?????????Unknown