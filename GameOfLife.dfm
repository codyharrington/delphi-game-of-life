object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'Conway'#39's Game of Life'
  ClientHeight = 453
  ClientWidth = 785
  Color = clBtnFace
  Constraints.MinHeight = 480
  Constraints.MinWidth = 640
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnResize = FormResize
  DesignSize = (
    785
    453)
  PixelsPerInch = 96
  TextHeight = 13
  object MainGrid: TDrawGrid
    AlignWithMargins = True
    Left = 0
    Top = 0
    Width = 785
    Height = 393
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelInner = bvNone
    BevelOuter = bvNone
    BiDiMode = bdLeftToRight
    DefaultColWidth = 20
    DefaultRowHeight = 20
    DefaultDrawing = False
    FixedCols = 0
    FixedRows = 0
    ParentBiDiMode = False
    ScrollBars = ssNone
    TabOrder = 0
    OnDrawCell = MainGridDrawCell
    OnSelectCell = MainGridSelectCell
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 424
    Width = 785
    Height = 29
    Panels = <>
    SimplePanel = True
  end
  object ButtonPanel: TPanel
    Left = 0
    Top = 387
    Width = 785
    Height = 41
    Anchors = [akLeft, akRight, akBottom]
    TabOrder = 2
    object PeriodLabel: TLabel
      Left = 368
      Top = 12
      Width = 54
      Height = 13
      Caption = 'Period (ms)'
    end
    object StartButton: TButton
      Left = 8
      Top = 6
      Width = 75
      Height = 25
      Caption = 'Start'
      TabOrder = 0
      OnClick = StartButtonClick
    end
    object PauseButton: TButton
      Left = 89
      Top = 6
      Width = 75
      Height = 25
      Caption = 'Pause'
      TabOrder = 1
      OnClick = PauseButtonClick
    end
    object TimeDurationSpinEdit: TSpinEdit
      Left = 436
      Top = 8
      Width = 121
      Height = 22
      MaxValue = 3000
      MinValue = 1
      TabOrder = 2
      Value = 100
    end
    object RandomiseButton: TButton
      Left = 170
      Top = 6
      Width = 75
      Height = 25
      Caption = 'Randomise'
      TabOrder = 3
      OnClick = RandomiseButtonClick
    end
    object ClearButton: TButton
      Left = 251
      Top = 6
      Width = 75
      Height = 25
      Caption = 'Clear'
      TabOrder = 4
      OnClick = ClearButtonClick
    end
  end
  object PeriodTimer: TTimer
    Enabled = False
    Interval = 500
    OnTimer = PeriodTimerTimer
    Left = 632
    Top = 48
  end
end
