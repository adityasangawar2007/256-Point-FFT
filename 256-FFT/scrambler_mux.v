module scrambler_mux(
                        input [4:0] cycle,
                        input [19:0] in_r0,in_r1,in_r2,in_r3,in_r4,in_r5,in_r6,in_r7,in_r8,in_r9,in_r10,in_r11,in_r12,in_r13,in_r14,in_r15,in_r16,in_r17,in_r18,in_r19,in_r20,in_r21,in_r22,in_r23,in_r24,in_r25,in_r26,in_r27,in_r28,in_r29,in_r30,in_r31,in_r32,in_r33,in_r34,in_r35,in_r36,in_r37,in_r38,in_r39,in_r40,in_r41,in_r42,in_r43,in_r44,in_r45,in_r46,in_r47,in_r48,in_r49,in_r50,in_r51,in_r52,in_r53,in_r54,in_r55,in_r56,in_r57,in_r58,in_r59,in_r60,in_r61,in_r62,in_r63,
                        input [19:0] in_r64,in_r65,in_r66,in_r67,in_r68,in_r69,in_r70,in_r71,in_r72,in_r73,in_r74,in_r75,in_r76,in_r77,in_r78,in_r79,in_r80,in_r81,in_r82,in_r83,in_r84,in_r85,in_r86,in_r87,in_r88,in_r89,in_r90,in_r91,in_r92,in_r93,in_r94,in_r95,in_r96,in_r97,in_r98,in_r99,in_r100,in_r101,in_r102,in_r103,in_r104,in_r105,in_r106,in_r107,in_r108,in_r109,in_r110,in_r111,in_r112,in_r113,in_r114,in_r115,in_r116,in_r117,in_r118,in_r119,in_r120,in_r121,in_r122,in_r123,in_r124,in_r125,in_r126,in_r127,
                        input [19:0] in_r128,in_r129,in_r130,in_r131,in_r132,in_r133,in_r134,in_r135,in_r136,in_r137,in_r138,in_r139,in_r140,in_r141,in_r142,in_r143,in_r144,in_r145,in_r146,in_r147,in_r148,in_r149,in_r150,in_r151,in_r152,in_r153,in_r154,in_r155,in_r156,in_r157,in_r158,in_r159,in_r160,in_r161,in_r162,in_r163,in_r164,in_r165,in_r166,in_r167,in_r168,in_r169,in_r170,in_r171,in_r172,in_r173,in_r174,in_r175,in_r176,in_r177,in_r178,in_r179,in_r180,in_r181,in_r182,in_r183,in_r184,in_r185,in_r186,in_r187,in_r188,in_r189,in_r190,in_r191,
                        input [19:0] in_r192,in_r193,in_r194,in_r195,in_r196,in_r197,in_r198,in_r199,in_r200,in_r201,in_r202,in_r203,in_r204,in_r205,in_r206,in_r207,in_r208,in_r209,in_r210,in_r211,in_r212,in_r213,in_r214,in_r215,in_r216,in_r217,in_r218,in_r219,in_r220,in_r221,in_r222,in_r223,in_r224,in_r225,in_r226,in_r227,in_r228,in_r229,in_r230,in_r231,in_r232,in_r233,in_r234,in_r235,in_r236,in_r237,in_r238,in_r239,in_r240,in_r241,in_r242,in_r243,in_r244,in_r245,in_r246,in_r247,in_r248,in_r249,in_r250,in_r251,in_r252,in_r253,in_r254,in_r255,
                        input [19:0] in_i0,in_i1,in_i2,in_i3,in_i4,in_i5,in_i6,in_i7,in_i8,in_i9,in_i10,in_i11,in_i12,in_i13,in_i14,in_i15,in_i16,in_i17,in_i18,in_i19,in_i20,in_i21,in_i22,in_i23,in_i24,in_i25,in_i26,in_i27,in_i28,in_i29,in_i30,in_i31,in_i32,in_i33,in_i34,in_i35,in_i36,in_i37,in_i38,in_i39,in_i40,in_i41,in_i42,in_i43,in_i44,in_i45,in_i46,in_i47,in_i48,in_i49,in_i50,in_i51,in_i52,in_i53,in_i54,in_i55,in_i56,in_i57,in_i58,in_i59,in_i60,in_i61,in_i62,in_i63,in_i64,in_i65,in_i66,in_i67,in_i68,in_i69,in_i70,in_i71,in_i72,in_i73,in_i74,in_i75,in_i76,in_i77,in_i78,in_i79,in_i80,in_i81,in_i82,in_i83,in_i84,in_i85,in_i86,in_i87,in_i88,in_i89,in_i90,in_i91,in_i92,in_i93,in_i94,in_i95,in_i96,in_i97,in_i98,in_i99,in_i100,in_i101,in_i102,in_i103,in_i104,in_i105,in_i106,in_i107,in_i108,in_i109,in_i110,in_i111,in_i112,in_i113,in_i114,in_i115,in_i116,in_i117,in_i118,in_i119,in_i120,in_i121,in_i122,in_i123,in_i124,in_i125,in_i126,in_i127,in_i128,in_i129,in_i130,in_i131,in_i132,in_i133,in_i134,in_i135,in_i136,in_i137,in_i138,in_i139,in_i140,in_i141,in_i142,in_i143,in_i144,in_i145,in_i146,in_i147,in_i148,in_i149,in_i150,in_i151,in_i152,in_i153,in_i154,in_i155,in_i156,in_i157,in_i158,in_i159,in_i160,in_i161,in_i162,in_i163,in_i164,in_i165,in_i166,in_i167,in_i168,in_i169,in_i170,in_i171,in_i172,in_i173,in_i174,in_i175,in_i176,in_i177,in_i178,in_i179,in_i180,in_i181,in_i182,in_i183,in_i184,in_i185,in_i186,in_i187,in_i188,in_i189,in_i190,in_i191,in_i192,in_i193,in_i194,in_i195,in_i196,in_i197,in_i198,in_i199,in_i200,in_i201,in_i202,in_i203,in_i204,in_i205,in_i206,in_i207,in_i208,in_i209,in_i210,in_i211,in_i212,in_i213,in_i214,in_i215,in_i216,in_i217,in_i218,in_i219,in_i220,in_i221,in_i222,in_i223,in_i224,in_i225,in_i226,in_i227,in_i228,in_i229,in_i230,in_i231,in_i232,in_i233,in_i234,in_i235,in_i236,in_i237,in_i238,in_i239,in_i240,in_i241,in_i242,in_i243,in_i244,in_i245,in_i246,in_i247,in_i248,in_i249,in_i250,in_i251,in_i252,in_i253,in_i254,in_i255,
                        output reg [55:0] out_0, out_1, out_2, out_3, out_4, out_5, out_6, out_7
                    );

always @ (cycle) begin
    case (cycle)
    0: begin
        out_0 = {in_r0,in_i0};
        out_1 = {in_r1,in_i1};
        out_2 = {in_r2,in_i2};
        out_3 = {in_r3,in_i3};
        out_4 = {in_r4,in_i4};
        out_5 = {in_r5,in_i5};
        out_6 = {in_r6,in_i6};
        out_7 = {in_r7,in_i7};
    end
    1: begin
        out_0 = {in_r8,in_i8};
        out_1 = {in_r9,in_i9};
        out_2 = {in_r10,in_i10};
        out_3 = {in_r11,in_i11};
        out_4 = {in_r12,in_i12};
        out_5 = {in_r13,in_i13};
        out_6 = {in_r14,in_i14};
        out_7 = {in_r15,in_i15};
    end
    2: begin
        out_0 = {in_r16,in_i16};
        out_1 = {in_r17,in_i17};
        out_2 = {in_r18,in_i18};
        out_3 = {in_r19,in_i19};
        out_4 = {in_r20,in_i20};
        out_5 = {in_r21,in_i21};
        out_6 = {in_r22,in_i22};
        out_7 = {in_r23,in_i23};
    end
    3: begin
        out_0 = {in_r24,in_i24};
        out_1 = {in_r25,in_i25};
        out_2 = {in_r26,in_i26};
        out_3 = {in_r27,in_i27};
        out_4 = {in_r28,in_i28};
        out_5 = {in_r29,in_i29};
        out_6 = {in_r30,in_i30};
        out_7 = {in_r31,in_i31};
    end
    4: begin
        out_0 = {in_r32,in_i32};
        out_1 = {in_r33,in_i33};
        out_2 = {in_r34,in_i34};
        out_3 = {in_r35,in_i35};
        out_4 = {in_r36,in_i36};
        out_5 = {in_r37,in_i37};
        out_6 = {in_r38,in_i38};
        out_7 = {in_r39,in_i39};
    end
    5: begin
        out_0 = {in_r40,in_i40};
        out_1 = {in_r41,in_i41};
        out_2 = {in_r42,in_i42};
        out_3 = {in_r43,in_i43};
        out_4 = {in_r44,in_i44};
        out_5 = {in_r45,in_i45};
        out_6 = {in_r46,in_i46};
        out_7 = {in_r47,in_i47};
    end
    6: begin
        out_0 = {in_r48,in_i48};
        out_1 = {in_r49,in_i49};
        out_2 = {in_r50,in_i50};
        out_3 = {in_r51,in_i51};
        out_4 = {in_r52,in_i52};
        out_5 = {in_r53,in_i53};
        out_6 = {in_r54,in_i54};
        out_7 = {in_r55,in_i55};
    end
    7: begin
        out_0 = {in_r56,in_i56};
        out_1 = {in_r57,in_i57};
        out_2 = {in_r58,in_i58};
        out_3 = {in_r59,in_i59};
        out_4 = {in_r60,in_i60};
        out_5 = {in_r61,in_i61};
        out_6 = {in_r62,in_i62};
        out_7 = {in_r63,in_i63};
    end
    8: begin
        out_0 = {in_r64,in_i64};
        out_1 = {in_r65,in_i65};
        out_2 = {in_r66,in_i66};
        out_3 = {in_r67,in_i67};
        out_4 = {in_r68,in_i68};
        out_5 = {in_r69,in_i69};
        out_6 = {in_r70,in_i70};
        out_7 = {in_r71,in_i71};
    end
    9: begin
        out_0 = {in_r72,in_i72};
        out_1 = {in_r73,in_i73};
        out_2 = {in_r74,in_i74};
        out_3 = {in_r75,in_i75};
        out_4 = {in_r76,in_i76};
        out_5 = {in_r77,in_i77};
        out_6 = {in_r78,in_i78};
        out_7 = {in_r79,in_i79};
    end
    10: begin
        out_0 = {in_r80,in_i80};
        out_1 = {in_r81,in_i81};
        out_2 = {in_r82,in_i82};
        out_3 = {in_r83,in_i83};
        out_4 = {in_r83,in_i83};
        out_5 = {in_r84,in_i84};
        out_6 = {in_r85,in_i85};
        out_7 = {in_r86,in_i86};
    end
    11: begin
        out_0 = {in_r88,in_i88};
        out_1 = {in_r89,in_i89};
        out_2 = {in_r90,in_i90};
        out_3 = {in_r91,in_i91};
        out_4 = {in_r92,in_i92};
        out_5 = {in_r93,in_i93};
        out_6 = {in_r94,in_i94};
        out_7 = {in_r95,in_i95};
    end
    12: begin
            out_0 = {in_r96,in_i96};
            out_1 = {in_r97,in_i97};
            out_2 = {in_r98,in_i98};
            out_3 = {in_r99,in_i99};
            out_4 = {in_r100,in_i100};
            out_5 = {in_r101,in_i101};
            out_6 = {in_r102,in_i102};
            out_7 = {in_r103,in_i103};
    end
    13: begin
            out_0 = {in_r104,in_i104};
            out_1 = {in_r105,in_i105};
            out_2 = {in_r106,in_i106};
            out_3 = {in_r107,in_i107};
            out_4 = {in_r108,in_i108};
            out_5 = {in_r109,in_i109};
            out_6 = {in_r110,in_i110};
            out_7 = {in_r111,in_i111};
    end
    14: begin
            out_0 = {in_r112,in_i112};
            out_1 = {in_r113,in_i113};
            out_2 = {in_r114,in_i114};
            out_3 = {in_r115,in_i115};
            out_4 = {in_r116,in_i116};
            out_5 = {in_r117,in_i117};
            out_6 = {in_r118,in_i118};
            out_7 = {in_r119,in_i119};
    end
    15: begin
            out_0 = {in_r120,in_i120};
            out_1 = {in_r121,in_i121};
            out_2 = {in_r122,in_i122};
            out_3 = {in_r123,in_i123};
            out_4 = {in_r124,in_i124};
            out_5 = {in_r125,in_i125};
            out_6 = {in_r126,in_i126};
            out_7 = {in_r127,in_i127};
    end
    16: begin
            out_0 = {in_r128,in_i128};
            out_1 = {in_r129,in_i129};
            out_2 = {in_r130,in_i130};
            out_3 = {in_r131,in_i131};
            out_4 = {in_r132,in_i132};
            out_5 = {in_r133,in_i133};
            out_6 = {in_r134,in_i134};
            out_7 = {in_r135,in_i135};
    end
    17: begin
            out_0 = {in_r136,in_i136};
            out_1 = {in_r137,in_i137};
            out_2 = {in_r138,in_i138};
            out_3 = {in_r139,in_i139};
            out_4 = {in_r140,in_i140};
            out_5 = {in_r141,in_i141};
            out_6 = {in_r142,in_i142};
            out_7 = {in_r143,in_i143};
    end
    18: begin
            out_0 = {in_r144,in_i144};
            out_1 = {in_r145,in_i145};
            out_2 = {in_r146,in_i146};
            out_3 = {in_r147,in_i147};
            out_4 = {in_r148,in_i148};
            out_5 = {in_r149,in_i149};
            out_6 = {in_r150,in_i150};
            out_7 = {in_r151,in_i151};
    end
    19: begin
            out_0 = {in_r152,in_i152};
            out_1 = {in_r153,in_i153};
            out_2 = {in_r154,in_i154};
            out_3 = {in_r155,in_i155};
            out_4 = {in_r156,in_i156};
            out_5 = {in_r157,in_i157};
            out_6 = {in_r158,in_i158};
            out_7 = {in_r159,in_i159};
    end
    20: begin
            out_0 = {in_r160,in_i160};
            out_1 = {in_r161,in_i161};
            out_2 = {in_r162,in_i162};
            out_3 = {in_r163,in_i163};
            out_4 = {in_r164,in_i164};
            out_5 = {in_r165,in_i165};
            out_6 = {in_r166,in_i166};
            out_7 = {in_r167,in_i167};
    end
    21: begin
            out_0 = {in_r168,in_i168};
            out_1 = {in_r169,in_i169};
            out_2 = {in_r170,in_i170};
            out_3 = {in_r171,in_i171};
            out_4 = {in_r172,in_i172};
            out_5 = {in_r173,in_i173};
            out_6 = {in_r174,in_i174};
            out_7 = {in_r175,in_i175};
    end
    22: begin
            out_0 = {in_r176,in_i176};
            out_1 = {in_r177,in_i177};
            out_2 = {in_r178,in_i178};
            out_3 = {in_r179,in_i179};
            out_4 = {in_r180,in_i180};
            out_5 = {in_r181,in_i181};
            out_6 = {in_r182,in_i182};
            out_7 = {in_r183,in_i183};
    end
    23: begin
            out_0 = {in_r184,in_i184};
            out_1 = {in_r185,in_i185};
            out_2 = {in_r186,in_i186};
            out_3 = {in_r187,in_i187};
            out_4 = {in_r188,in_i188};
            out_5 = {in_r189,in_i189};
            out_6 = {in_r190,in_i190};
            out_7 = {in_r191,in_i191};
    end
    24: begin
            out_0 = {in_r192,in_i192};
            out_1 = {in_r193,in_i193};
            out_2 = {in_r194,in_i194};
            out_3 = {in_r195,in_i195};
            out_4 = {in_r196,in_i196};
            out_5 = {in_r197,in_i197};
            out_6 = {in_r198,in_i198};
            out_7 = {in_r199,in_i199};
    end
    25: begin
            out_0 = {in_r200,in_i200};
            out_1 = {in_r201,in_i201};
            out_2 = {in_r202,in_i202};
            out_3 = {in_r203,in_i203};
            out_4 = {in_r204,in_i204};
            out_5 = {in_r205,in_i205};
            out_6 = {in_r206,in_i206};
            out_7 = {in_r207,in_i207};
    end
    26: begin
            out_0 = {in_r208,in_i208};
            out_1 = {in_r209,in_i209};
            out_2 = {in_r210,in_i210};
            out_3 = {in_r211,in_i211};
            out_4 = {in_r212,in_i212};
            out_5 = {in_r213,in_i213};
            out_6 = {in_r214,in_i214};
            out_7 = {in_r215,in_i215};
    end
    27: begin
            out_0 = {in_r216,in_i216};
            out_1 = {in_r217,in_i217};
            out_2 = {in_r218,in_i218};
            out_3 = {in_r219,in_i219};
            out_4 = {in_r220,in_i220};
            out_5 = {in_r221,in_i221};
            out_6 = {in_r222,in_i222};
            out_7 = {in_r223,in_i223};
    end
    28: begin
            out_0 = {in_r224,in_i224};
            out_1 = {in_r225,in_i225};
            out_2 = {in_r226,in_i226};
            out_3 = {in_r227,in_i227};
            out_4 = {in_r228,in_i228};
            out_5 = {in_r229,in_i229};
            out_6 = {in_r230,in_i230};
            out_7 = {in_r231,in_i231};
    end
    29: begin
            out_0 = {in_r232,in_i232};
            out_1 = {in_r233,in_i233};
            out_2 = {in_r234,in_i234};
            out_3 = {in_r235,in_i235};
            out_4 = {in_r236,in_i236};
            out_5 = {in_r237,in_i237};
            out_6 = {in_r238,in_i238};
            out_7 = {in_r239,in_i239};
    end
    30: begin
            out_0 = {in_r240,in_i240};
            out_1 = {in_r241,in_i241};
            out_2 = {in_r242,in_i242};
            out_3 = {in_r243,in_i243};
            out_4 = {in_r244,in_i244};
            out_5 = {in_r245,in_i245};
            out_6 = {in_r246,in_i246};
            out_7 = {in_r247,in_i247};
    end
    31: begin
            out_0 = {in_r248,in_i248};
            out_1 = {in_r249,in_i249};
            out_2 = {in_r250,in_i250};
            out_3 = {in_r251,in_i251};
            out_4 = {in_r252,in_i252};
            out_5 = {in_r253,in_i253};
            out_6 = {in_r254,in_i254};
            out_7 = {in_r255,in_i255};
    end
    default: begin
    out_0 = 0; out_1 = 0; out_2 = 0; out_3 = 0; out_4 = 0; out_5 = 0; out_6 = 0; out_7 =0;
    end
    endcase
end

endmodule
