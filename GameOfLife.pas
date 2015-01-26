unit GameOfLife;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.ExtCtrls, DrawingUtils,
  Vcl.ComCtrls;

type
  TMainForm = class(TForm)
    MainGrid: TDrawGrid;
    StatusBar1: TStatusBar;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure MainGridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    property Cells: Array of Array of TAutomataCell;
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

procedure TMainForm.FormCreate(Sender: TObject);
begin
  SetLength(Cells, MainGrid.RowCount, MainGrid.ColCount);

  TDrawingUtils.ResizeGrid(MainForm, MainGrid);

  MainGrid.Canvas.Brush.Color := clBlack;
  Timer1.Interval := 1000;
end;

procedure TMainForm.FormResize(Sender: TObject);
begin
  TDrawingUtils.ResizeGrid(MainForm, MainGrid);
end;

procedure TMainForm.MainGridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
var
  SelectedRect: TGridRect;
begin
  SelectedRect := MainGrid.Selection;
  StatusBar1.SimpleText := Format('Selected rectangle: (%d, %d) (%d, %d)', [SelectedRect.TopLeft.X, SelectedRect.TopLeft.Y,
    SelectedRect.BottomRight.X, SelectedRect.BottomRight.Y]);
end;

procedure TMainForm.Timer1Timer(Sender: TObject);
begin
  TDrawingUtils.UpdateCellGrid(MainGrid);
end;

end.
