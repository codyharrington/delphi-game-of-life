object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'MainForm'
  ClientHeight = 442
  ClientWidth = 744
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
    744
    442)
  PixelsPerInch = 96
  TextHeight = 13
  object MainGrid: TDrawGrid
    AlignWithMargins = True
    Left = 0
    Top = 0
    Width = 745
    Height = 425
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelInner = bvNone
    BevelOuter = bvNone
    BiDiMode = bdLeftToRight
    ParentBiDiMode = False
    TabOrder = 0
    OnSelectCell = MainGridSelectCell
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 423
    Width = 744
    Height = 19
    Panels = <>
    SimplePanel = True
    ExplicitLeft = 224
    ExplicitTop = 431
  end
end
