object frmVendasView: TfrmVendasView
  Left = 215
  Top = 147
  Width = 828
  Height = 478
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Venda'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object stbBarraStatus: TStatusBar
    Left = 0
    Top = 420
    Width = 812
    Height = 19
    Panels = <
      item
        Width = 100
      end
      item
        Width = 50
      end>
  end
  object pnlBotoes: TPanel
    Left = 0
    Top = 350
    Width = 812
    Height = 70
    Align = alBottom
    TabOrder = 1
    object btnIncluir: TBitBtn
      Left = 13
      Top = 8
      Width = 75
      Height = 25
      Caption = '&Incluir'
      TabOrder = 0
      OnClick = btnIncluirClick
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000C40E0000C40E00000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFBAE3C170CE8426B7461DB9401DB94026B74670CE84BAE3C1FFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9FDFA4EB86119C1401FCE4C24DC5827
        DD5C27DD5C24DC581FCE4C19C1404EB861F9FDFAFFFFFFFFFFFFFFFFFFFAFDFB
        21A93A1ED04E22D55521D35503B82C00A71200A71203B82C21D35522D5551ED0
        4E21A93AFAFDFBFFFFFFFFFFFF4DB15A1ECE4D21D3541FCC4D0FCC4500AD13FF
        FFFFFFFFFF00AD130FCC451FCC4D21D3541ECE4D4DB15AFFFFFFBCDEBE17BA3F
        21DA5A1ECC5120D0530DC74200BE25FFFFFFFFFFFF00BE250DC74220D0531ECC
        5121DA5A17BA3FBCDEBE6ABB7317D15120D45F0BCC4A04CA4300C13300BC22FF
        FFFFFFFFFF00BD2700C23B10CA4B0ECC4C20D45F17D1516ABB7330A03E33E67A
        00B62D00AD1300AD1300AD1300AD13FFFFFFFFFFFF00AD1300BD2700BD2300AD
        1300B62D33E67A30A14030A34281FCC300AF21FFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00AF2181FCC430A04122943685FDCC
        2AC262FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FF2AC26285FDCC22943532923C7BFAC33CD07D71C7801EBF5921C05B0ABA4DFF
        FFFFFFFFFF10BC5122C05C1EBF5971C7803CD07D7BFAC332923C67AA668AE5B9
        65EAB050DF9756DF9C41DB8D22C05CFFFFFFFFFFFF22C05C49DC9356DF9C50DF
        9765EAB08AE5B967AA66B9D3B94EB068AFFFEA5EE0A156E19F45DE9766D589FF
        FFFFFFFFFF23C05B50E09E56E19F5EE0A1AFFFEA4EB068B9D3B9FFFFFF458845
        7BDCA8B6FFEF76E5B551DFA366D589FFFFFFFFFFFF24BF5956E2A876E5B5B6FF
        EF7BDCA8458845FFFFFFFFFFFFFAFCFA1572156DD6A3B7FFF5AAF7E370E0B022
        C05C22C05C74E2B3ABF7E4B7FFF56DD6A3157215FAFCFAFFFFFFFFFFFFFFFFFF
        F9FBF945854538A75E7FE1B8A9FFECB9FFFBB9FFFBA9FFEC7FE1B838A75E4585
        45F9FBF9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFB7CDB767A567247C3228
        8637288637247C3267A567B7CDB7FFFFFFFFFFFFFFFFFFFFFFFF}
    end
    object btnConsultar: TBitBtn
      Left = 93
      Top = 8
      Width = 75
      Height = 25
      Caption = '&Consultar'
      TabOrder = 3
      OnClick = btnConsultarClick
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000C40E0000C40E00000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FF6666663E3E3E979797FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFDFDFD5050503C3C3C2C2C2C3B3B3BFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFE5656565858
        585151513B3B3B585858FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFBFBFB5F5F5F7A7A7A767676545454535353FFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7A7A7A858585B0B0B07272
        727B7B7BFFFFFFFFFFFFFFFFFFFFFFFFDEDEDEBCBCBCB1B1B1ADADADA9A9A9A3
        A3A3AAAAAAB1B1B16969697B7B7B828282FFFFFFFFFFFFFFFFFFFFFFFFD5D5D5
        C8C8C8EBD2B2F4D3A5F1D1A6F4D1A4EFCCA7A3A3A3B2B2B2B4B4B49C9C9CFFFF
        FFFFFFFFFFFFFFFFFFFFECECECCCCCCCF2DCB5F1D9B4EFDDBDEFDDBDEDDAB8EF
        D5AFF9D5A7A6A6A6ADADADFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC9C9C9F3E7CA
        F6E5C3F4EBD0F4EED1F4EED3F5ECD0F2E5C7F2DFBCF7DEB58A8A8AF4F4F4FFFF
        FFFFFFFFFFFFFFFFFFFFBABABAFAF1D5F6F2D4F6F2D6F6F2D7F6F2D6F6F2D6F5
        F1D5F4EBCDFDE9C3A4A4A4D9D9D9FFFFFFFFFFFFFFFFFFFFFFFFA8A8A8FFFAE7
        F7F2D5F5EFD5F7F0D6F7F1D8F6F1D8F6F1D6F5F2D6FFF5D3A9A9A9CDCDCDFFFF
        FFFFFFFFFFFFFFFFFFFFBABABAFEFAEAFAF6E3FBFAF1FDFBF3F9F2DDF7F2DAF6
        F1D7F5F0D5FFFEDDA7A7A7D9D9D9FFFFFFFFFFFFFFFFFFFFFFFFC6C6C6F9FAEA
        FFFBEBFEFFFEFFFFFFF9F7ECF9F5E1F7F2DEFCF7DFFFFFEA919191FEFEFEFFFF
        FFFFFFFFFFFFFFFFFFFFDDDDDDCCCCCCFFFFF1FFFFF3FEFDF7FCFBF4FCF9EFFF
        FEEFFFFFF5C1C1C1D5D5D5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE6E6E6
        C6C6C6F8F7ECFFFFF7FFFFF7FFFFF3FEFDEEBCBCBCC5C5C5FFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE1E1E1CFCFCFC3C3C3C3C3C3C3C3C3CF
        CFCFDFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
    end
    object btnPesquisar: TBitBtn
      Left = 13
      Top = 36
      Width = 75
      Height = 25
      Caption = 'Pesquisar'
      TabOrder = 4
      OnClick = btnPesquisarClick
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000C40E0000C40E00000000000000000000FFFFFFFFFFFF
        94713B94713B94713B96713B96713B96713B96713B96713B96713B94713B9471
        3B5D3E242F5B912F5B91FFFFFFFFFFFF94713BFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFC2D1F62F5B91C1FFFF005FDEFFFFFFFFFFFF
        A38453FAEEEEB98361B88160BC8767C5916FC89674BE8B6BCC8F64714B4B2F5B
        91B6FFFF005FDEFFFFFFFFFFFFFFFFFFA38453FFFFFFF8F8F5FFFFFFECF1F798
        7771987771925B4CD9E4EB2F5B91AEFBFF005FDE543B21FFFFFFFFFFFFFFFFFF
        A38453F3E3DEC8906E8F513A724535DCD09FF6F5C5FFFFFD925B4C597097005F
        DEB8C0C6754605FFFFFFFFFFFFFFFFFFAD9060FFFFFFF3F9F9987771F8D69EFB
        EBC0FFFAD9FFFFFDFFFFFFA9614BD2DFEBFFFBE7754605FFFFFFFFFFFFFFFFFF
        AD9060F9E9E18D5B4AC48962F2C69AECD2B0FEF8DAFAF5DEFFFFFFDBD0CEBF88
        75F8F9F2784706FFFFFFFFFFFFFFFFFFAC9167FFFFFFC3B6B8C4835AF6D8ACF0
        DABEF8EAD0FEF8DEFFFDE3E9E4D1BEB0B1FAF6EE784A08FFFFFFFFFFFFFFFFFF
        B19F7CFCEDE7A77D6CBA7455FCDEABFFFFFFF1DEBFF2E0BBFFFDD3CCBC98AC87
        7DEDE5D77A4C0BFFFFFFFFFFFFFFFFFFBAA180FFFFFFFFFFFFA57668D68952FB
        E0A9F2DAAEF6D9A1F6D9A18E6A62DCD1CDD9CDB57D5010FFFFFFFFFFFFFFFFFF
        C6B191F5E8E3C28A69B98E7BB0897FB8714FCC8C63D09D77A0786C874B2DAD7A
        51C0AC88815518FFFFFFFFFFFFFFFFFFC4B192FFFFFFFCFFFFFFFFFFF8FBFACF
        C6C2C6B5B6B3A19ACCBA9EF9F8F0E5E1D0B3976D865A1DFFFFFFFFFFFFFFFFFF
        C8B89AF2E6DFBD8563BE8664BC8563BB8563BF84639C623DCDBA99E5E1D0CCB6
        9B9C7741FFFFFFFFFFFFFFFFFFFFFFFFC8B89AFFFFFFFFFFFFFFFFFFFCFCFAED
        EDEAEBE5D9D3C0A1B9A883D4C5AF946D31FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        C8BA9DFFFFFFFFFFFFF8F6F5F0E5DEDED5C4D5C2AABEA57E9A7B449D7741FFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC8B89ACCB89CC6B497C3AF90C2AE90BF
        A780BBA077A890608D652DFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
    end
    object btnConfirmar: TBitBtn
      Left = 648
      Top = 8
      Width = 75
      Height = 25
      Caption = 'C&onfirmar'
      Enabled = False
      TabOrder = 1
      OnClick = btnConfirmarClick
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000C40E0000C40E00000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFBAE3C170CE8426B7461DB9401DB94026B74670CE84BAE3C1FFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9FDFA4EB86119C1401FCE4C24DC5827
        DD5C27DD5C24DC581FCE4C19C1404EB861F9FDFAFFFFFFFFFFFFFFFFFFFAFDFB
        21A93A1ED04E21D45420D05304B62A18C4401DCE4A18C84420D15121D4541ED0
        4E21A93AFAFDFBFFFFFFFFFFFF4DB15A1ECE4D22D45615C9481CAC2F9DD2A137
        AF4614C13B1FD24E1ECE4B1ECD4A20D2531ECE4D4DB15AFFFFFFBCDEBE17BA3F
        21D85A13C64612A826F2F4ECFFFFFFEAF2E626AA380DC03920D24F1ECE491DCD
        4D20D75817BA3FBCDEBE6ABB7318D15214CB4E0BA01EF2F4ECFFFBFFFFFAFFFF
        FFFFEAF2E623A8350BC03A1ED3591CCF531ED25818CF516ABB7330A03E2DE172
        1BA82DF2F4ECFFF8FFEAF2E6A9D5A4EEF2EBFFFFFFD0EBD323A8340AC24218D6
        6213CF5430E17330A14030A34265EAA158B25CEAF2E6EAF2E60EB42F00BF303A
        B649F2F4ECFFFFFFEAF2E623A83307C13D24D86973F0B130A04122943678F4BC
        49CD7A74BF7F2DB64C24D3672ED87219CC5A48B558EAF2E6FFFFFFEAF2E626A7
        3125D06077F6BE22943532923C71F2B561E4A84CDB955BE1A561DEA563DDA463
        E2AB4DDA964FB860EEF2E8FFFFFFEAF2E62AB3436DF0B332923C67AA6686E3B5
        62E7A95DE2A460E2A65FE1A65FE1A65EE1A563E5AD4CDA954DB75EEAF0E5FFFF
        FF61BC6580DFAE67AA66B9D3B94EB068A8FCE15FE1A257E09F5BE0A35DE1A45D
        E1A45DE1A461E5AB4EDC9748BA605DC27096EABF4EB068B9D3B9FFFFFF458845
        7BDBA7B0FCE876E5B562E3AA5EE0A65EE1A65EE1A65EE0A566E6B06FE3AFA7F9
        E07ADCA8458845FFFFFFFFFFFFFAFCFA1572156DD6A3B3FDF0A4F5DF8CE9C78C
        E8C48AE7C28DE9C6A5F5DEB3FDF06DD6A3157215FAFCFAFFFFFFFFFFFFFFFFFF
        F9FBF945854538A75E7FE1B8A9FFECB9FFFBB9FFFBA9FFEC7FE1B838A75E4585
        45F9FBF9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFB7CDB767A567247C3228
        8637288637247C3267A567B7CDB7FFFFFFFFFFFFFFFFFFFFFFFF}
    end
    object btnCancelar: TBitBtn
      Left = 728
      Top = 8
      Width = 75
      Height = 25
      Caption = '&Cancelar'
      Enabled = False
      TabOrder = 2
      OnClick = btnCancelarClick
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000C40E0000C40E00000000000000000000FFFFFF5B57D9
        2722CD2622CE2721CD251FCA241FCA241ECA251FCA251EC9251EC9261FCC231D
        C8261FCC5A55D9FFFFFF5F5FE12E2DFB2423EF0B06B6201DE52B29FA2824F428
        24F42723F42722F42925FC130DCE0A05B0211AEF2921FB5C5ADE2423D5272BEF
        1312B16A67BF1B1AB01F20E22D2EF4282AED2929EE2C2DF40E0DCA3F3CB59090
        CE1210B12321EE201CD12C2CD4100EBB918ED3FFFFFFADAAE0100FB21C20E030
        36F42F35F40D0DCE3835B8ECECF8FFFFFF6A67C60F0DC02B29D52F33DB1D24D7
        433DC3EBEAF8FFFFFFAFADE31D1BB91D24DE171CD73934BEEEEDF9FFFFFFACAA
        E41F1BBD252CE72D2CD83035DC384FFA161ED43A32C5EDEDF9FFFFFFD0CEF020
        1FC11E1DC0E2E2F6FFFFFFB3B1E81511BF232DE53241F72E2FD82D33DD364FF3
        3950F3151DD83E35CCDEDBF6FFFFFFCFCDF2CFCEF3FFFFFFD4D3F32321C7202C
        E33447F43144F22B2EDB5056E43B55F3334BEF3852F41F2ADF211DCBCDCCF4FF
        FFFFFFFFFFCDCBF42120CD2232E3354DF42F44EE364DF24D52E26E71EA6E82F7
        556AF24862F32B3BE8221FD2CDCBF3FFFFFFFFFFFFCDCBF4201DD2242FE4445D
        F35366F26A7DF66B6FE86B6FEC7388F7788CF66472F1514BE0D5D2F7FFFFFFDC
        DAF8DCDAF8FFFFFFDCDAF8655EE2575EEA7588F66F83F6686DEA6C71EE7891F7
        6779F25550E6CAC6F6FFFFFFE9E8FC5851E65954E6E0DEFAFFFFFFF6F5FD6F69
        E9575FEC748CF76A6FED6E75EF6F82F35E59EBC2BFF7FFFFFFF2F1FD6E66EC5D
        68EF6472F15E57EBC5C1F8FFFFFFF1F0FD7670EC616BF16D73EF6F77F15A5CEF
        928BF3FFFFFFF1F0FE6F68F05B64EF7A92F67A91F66775F25551EDC3BFF9FFFF
        FFAFA8F75857F06C70EF6C75F27A91F65A57F0AEA8F77771F35F68F27D96F679
        8EF5788EF57C94F66D7FF45F5BF0948CF55956F1758BF66A73F0949AF685A1F7
        7C94F65B5BF36975F584A1F88099F77F98F77F98F77E97F6819CF67588F55C5F
        F37990F5819DF79299F4FFFFFF969BF7747BF47177F4747CF47279F47279F471
        79F47179F47279F47178F4727AF4727AF47279F49499F6FFFFFF}
    end
    object btnSair: TBitBtn
      Left = 728
      Top = 40
      Width = 75
      Height = 25
      Caption = '&Sair'
      TabOrder = 5
      OnClick = btnSairClick
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000C40E0000C40E00000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFAC6A2CE1A53CE6C590F2E1C4F9F0
        E2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE5CDBAB6
        B6BA975B19DF9C1FCC891BCD8A1BCD8A1BD6A149E6BE74E4CEB7FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFB36623121019804A09E39C20CB891CCD8A1CCD8A
        1CCC891CD6941CAC641DFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC77C2D13
        111A864F09E49A21CD8A1DCF8B1DCF8B1DCE8A1DD8941BB36F2BFFFFFFFFFFFF
        FFFFFFFDFDFF2121CBFFFFFFD7924014111B8A530BE69E22CE8C1FCF8D1FCF8D
        1FCE8C1FD6941DB7742FFFFFFFFFFFFFFFFFFFFFFFFF1614D92429F4AE6D4125
        1A008E530ED89220CF8C1FD08F23D08F22CF8E22D79620BA79333039E71D2AE8
        232CE8222EEB2430EF2032FF1B25F900002FAA6F06E4EAF1BC7418D69324D292
        27D29127D89925BE7D36606DEF152EF4223AF42137F42338F2273AEF213CFF2B
        3FFF895645FAD273D29A3DD6982ED39229D4932BDA9C2DC282396A7BF44565F7
        4A67F64E69F6425CF31F3CF25E7FFF1F28B9A46820F0BA4DDEAE56DFAF58DBA7
        49D59A36DB9F31C6893E5960EF656FF1636DF16670F0495FF1638AFF8667B40D
        0300AA7628F2C46DE0B05DE0B25EE2B462E2B261E1AE4BCB8C3FFFFFFFFFFFFF
        FFFFFFFFFFFF3B40F05460FFE9A94E22180BA8793AF5CA77E2B768E3B869E3B8
        69E4B86AEAC377D1984DFFFFFFFFFFFFFFFFFFFBFAFF2222FFFFFFFFF7B64C1C
        1014B2803FF8D284E6BF73E7C074E7C074E7BF73ECCB80D59E53FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFF6B1441D1212B98949FDD991EAC681EAC581EAC5
        81EAC581F0D08FD9A457FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE7AC5B18
        0D0EC49957FFF2AFFFE09DFFE4A0F8DB9AF3D495F5DEA3DEAB5DFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFECB05C301F1B231F206E5A449E8663BBA77CDDC1
        8CF1D399FEEBBAE3B164FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEAB968DB
        A851CF9D4EC59346B98A40B38139CE9A47DFAB53E8B863E4B25F}
    end
  end
  object pnlPagamentos: TPanel
    Left = 0
    Top = 286
    Width = 812
    Height = 64
    Align = alBottom
    TabOrder = 2
    object lblPagamento: TLabel
      Left = 9
      Top = 25
      Width = 120
      Height = 13
      Caption = 'Forma de Pagamento'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblDesconto: TLabel
      Left = 303
      Top = 22
      Width = 63
      Height = 13
      Caption = 'Desconto (%)'
    end
    object lblValor: TLabel
      Left = 485
      Top = 21
      Width = 30
      Height = 13
      Caption = 'Valor'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblValorTotal: TLabel
      Left = 720
      Top = 9
      Width = 78
      Height = 16
      Caption = 'Valor Total'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
    end
    object cmbPagamento: TComboBox
      Left = 136
      Top = 17
      Width = 129
      Height = 21
      ItemHeight = 13
      TabOrder = 0
    end
    object edtDesconto: TNumEdit
      Left = 376
      Top = 16
      Width = 81
      Height = 21
      Alignment = taRightJustify
      Decimals = 2
      ShowSeparator = True
      TabOrder = 1
    end
    object edtValor: TNumEdit
      Left = 520
      Top = 14
      Width = 81
      Height = 21
      Alignment = taRightJustify
      Decimals = 2
      ShowSeparator = True
      TabOrder = 2
    end
    object edtTotalValor: TNumEdit
      Left = 720
      Top = 30
      Width = 81
      Height = 21
      Alignment = taRightJustify
      Decimals = 2
      ShowSeparator = True
      TabOrder = 3
    end
  end
  object pnlPedidos: TPanel
    Left = 0
    Top = 0
    Width = 812
    Height = 65
    Align = alTop
    TabOrder = 3
    object gbrPedidos: TGroupBox
      Left = 1
      Top = 1
      Width = 810
      Height = 63
      Align = alClient
      Caption = 'Pedido'
      TabOrder = 0
      object lblNome: TLabel
        Left = 448
        Top = 28
        Width = 33
        Height = 13
        Caption = 'Nome'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object btnUnidadeProduto: TSpeedButton
        Left = 415
        Top = 20
        Width = 25
        Height = 23
        Glyph.Data = {
          36060000424D3606000000000000360000002800000020000000100000000100
          180000000000000600003A0B00003A0B00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFB58C8C8C5A5A8C5A5A8C5A5A8C5A5A8C5A5A8C5A5A8C5A
          5A8C5A5A8C5A5AFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9090905F5F5F5F
          5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5FFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFB58C8CFFF7E7F7EFDEF7EFDEF7EFDEF7EFDEF7EFDEF7EF
          DEF7E7CE8C5A5AFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF909090F3F3F3EA
          EAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAE1E1E15F5F5FFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFB58C8CF7EFDEF7DECEF7DEC6F7DEC6F7DEC6F7DEC6EFDE
          CEEFDECE8C5A5AFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF909090EAEAEADB
          DBDBD9D9D9D9D9D9D9D9D9D9D9D9DADADADADADA5F5F5FFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFB58C8CFFF7E7FFD6A5FFD6A5FFD6A5FFD6A5FFD6A5FFD6
          A5EFDECE8C5A5AFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF909090F3F3F3CB
          CBCBCBCBCBCBCBCBCBCBCBCBCBCBCBCBCBDADADA5F5F5FFF00FFFF00FFB58C8C
          8C5A5A8C5A5A8C5A5AB58C8CFFF7EFF7DEC6F7DEC6F7DEC6F7DEC6F7DEBDF7E7
          CEEFDECE9C6B63FF00FFFF00FF9090905F5F5F5F5F5F5F5F5F909090F5F5F5D9
          D9D9D9D9D9D9D9D9D9D9D9D6D6D6E1E1E1DADADA6D6D6DFF00FFFF00FFB58C8C
          FFF7E7F7EFDEF7EFDEB58C8CFFF7EFF7E7CEF7DEC6F7DEC6F7DEC6F7DEC6F7E7
          D6EFDECE9C6B6BFF00FFFF00FF909090F3F3F3EAEAEAEAEAEA909090F5F5F5E1
          E1E1D9D9D9D9D9D9D9D9D9D9D9D9E3E3E3DADADA6F6F6FFF00FFFF00FFB58C8C
          F7EFDEF7DECEF7DEC6B58C8CFFFFF7FFD6A5FFD6A5FFD6A54C804C4C804C4C80
          4C4C804CA57B73FF00FFFF00FF909090EAEAEADBDBDBD9D9D9909090FCFCFCCB
          CBCBCBCBCBCBCBCB6B6B6B6B6B6B6B6B6B6B6B6B7C7C7CFF00FFFF00FFB58C8C
          FFF7E7FFD6A5FFD6A5B58C8CFFFFF7FFE7D6FFE7D6F7E7D64C804C52AE5752AE
          574C804CA57B73FF00FFFF00FF909090F3F3F3CBCBCBCBCBCB909090FCFCFCE4
          E4E4E4E4E4E3E3E36B6B6B8A8A8A8A8A8A6B6B6B7C7C7CFF00FFFF00FFB58C8C
          FFF7EFF7DEC6F7DEC6B58C8CFFFFFFFFFFFF4C804C4C804C4C804C52AE5752AE
          574C804C4C804C4C804CFF00FF909090F5F5F5D9D9D9D9D9D9909090FFFFFFFF
          FFFF6B6B6B6B6B6B6B6B6B8A8A8A8A8A8A6B6B6B6B6B6B6B6B6BFF00FFB58C8C
          FFF7EFF7E7CEF7DEC6B58C8CFFFFFFFFFFFF4C804C52AE5752AE5752AE5752AE
          5752AE5752AE574C804CFF00FF909090F5F5F5E1E1E1D9D9D9909090FFFFFFFF
          FFFF6B6B6B8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A6B6B6BFF00FFB58C8C
          FFFFF7FFD6A5FFD6A5B58C8CFFFFFFFFFFFF4C804C69CA8069CA8069CA8052AE
          5752AE5752AE574C804CFF00FF909090FCFCFCCBCBCBCBCBCB909090FFFFFFFF
          FFFF6B6B6BAAAAAAAAAAAAAAAAAA8A8A8A8A8A8A8A8A8A6B6B6BFF00FFB58C8C
          FFFFF7FFE7D6FFE7D6B58C8CB58C8CB58C8C4C804C4C804C4C804C69CA8052AE
          574C804C4C804C4C804CFF00FF909090FCFCFCE4E4E4E4E4E490909090909090
          90906B6B6B6B6B6B6B6B6BAAAAAA8A8A8A6B6B6B6B6B6B6B6B6BFF00FFB58C8C
          FFFFFFFFFFFFFFFFFFFFFFF7FFFFF7EFDEDED6C6C6BDADAD4C804C69CA8052AE
          574C804CFF00FFFF00FFFF00FF909090FFFFFFFFFFFFFFFFFFFCFCFCFCFCFCDF
          DFDFC7C7C7AEAEAE6B6B6BAAAAAA8A8A8A6B6B6BFF00FFFF00FFFF00FFB58C8C
          FFFFFFFFFFFFFFFFFFFFFFF7FFFFF7B58C8CB58C8CB58C8C4C804C4C804C4C80
          4C4C804CFF00FFFF00FFFF00FF909090FFFFFFFFFFFFFFFFFFFCFCFCFCFCFC90
          90909090909090906B6B6B6B6B6B6B6B6B6B6B6BFF00FFFF00FFFF00FFB58C8C
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFB58C8CEFB56BC68C7BFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FF909090FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF90
          9090A4A4A48C8C8CFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB58C8C
          B58C8CB58C8CB58C8CB58C8CB58C8CB58C8CBD8484FF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FF90909090909090909090909090909090909090
          9090898989FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
        NumGlyphs = 2
      end
      object lblCodigo: TLabel
        Left = 325
        Top = 31
        Width = 40
        Height = 13
        Caption = 'C'#243'digo'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblData: TLabel
        Left = 155
        Top = 30
        Width = 23
        Height = 13
        Caption = 'Data'
      end
      object Label1: TLabel
        Left = 16
        Top = 32
        Width = 46
        Height = 13
        Caption = 'N'#176' Venda'
      end
      object edtNome: TEdit
        Left = 486
        Top = 21
        Width = 313
        Height = 21
        CharCase = ecUpperCase
        TabOrder = 0
      end
      object edtCodigo: TEdit
        Left = 369
        Top = 24
        Width = 37
        Height = 21
        TabOrder = 1
      end
      object mskData: TMaskEdit
        Left = 184
        Top = 24
        Width = 86
        Height = 21
        EditMask = '##/##/####;1;_'
        MaxLength = 10
        TabOrder = 2
        Text = '  /  /    '
      end
      object edtNumeroVenda: TEdit
        Left = 70
        Top = 24
        Width = 56
        Height = 21
        TabOrder = 3
      end
    end
  end
  object pnlProdutos: TPanel
    Left = 0
    Top = 65
    Width = 812
    Height = 221
    Align = alClient
    TabOrder = 4
    object gbrProdutos: TGroupBox
      Left = 1
      Top = 1
      Width = 810
      Height = 219
      Align = alClient
      Caption = 'Produtos'
      TabOrder = 0
      object dbgProdutos: TDBGrid
        Left = 2
        Top = 15
        Width = 806
        Height = 202
        Align = alClient
        DataSource = dtsProdutos
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'ID'
            Title.Caption = 'C'#243'digo'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Descricao'
            Title.Caption = 'Descri'#231#227'o'
            Width = 423
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'UniPreco'
            Title.Caption = 'Pre'#231'o Uni.'
            Width = 72
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'UniSaida'
            Title.Caption = 'Unidade de Sa'#237'da'
            Width = 86
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Quantidade'
            Width = 75
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'TotalPreco'
            Title.Caption = 'Pre'#231'o Total'
            Visible = True
          end>
      end
    end
  end
  object dtsProdutos: TDataSource
    DataSet = cdsProdutos
    Left = 6
    Top = 119
  end
  object cdsProdutos: TClientDataSet
    Active = True
    Aggregates = <>
    Params = <>
    Left = 36
    Top = 119
    Data = {
      970000009619E0BD010000001800000006000000000003000000970002494404
      000100000000000944657363726963616F010049000000010005574944544802
      000200640008556E69507265636F080004000000000008556E69536169646101
      004900000001000557494454480200020014000A5175616E7469646164650800
      0400000000000A546F74616C507265636F08000400000000000000}
    object cdsProdutosID: TIntegerField
      FieldName = 'ID'
    end
    object cdsProdutosDescricao: TStringField
      FieldName = 'Descricao'
      Size = 100
    end
    object cdsProdutosUniPreco: TFloatField
      FieldName = 'UniPreco'
    end
    object cdsProdutosUniSaida: TStringField
      FieldName = 'UniSaida'
    end
    object cdsProdutosQuantidade: TFloatField
      FieldName = 'Quantidade'
    end
    object cdsProdutosTotalPreco: TFloatField
      FieldName = 'TotalPreco'
    end
  end
end
