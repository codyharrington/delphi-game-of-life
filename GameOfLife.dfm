object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'MainForm'
  ClientHeight = 445
  ClientWidth = 758
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
    758
    445)
  PixelsPerInch = 96
  TextHeight = 13
  object MainGrid: TDrawGrid
    AlignWithMargins = True
    Left = 0
    Top = -2
    Width = 758
    Height = 431
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelInner = bvNone
    BevelOuter = bvNone
    BiDiMode = bdLeftToRight
    FixedCols = 0
    FixedRows = 0
    ParentBiDiMode = False
    TabOrder = 0
    OnDrawCell = MainGridDrawCell
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 426
    Width = 758
    Height = 19
    Panels = <>
    SimplePanel = True
    ExplicitWidth = 751
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 632
    Top = 48
  end
end
