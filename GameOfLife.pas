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
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure MainGridSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

procedure TMainForm.FormCreate(Sender: TObject);
begin
  TDrawingUtils.ResizeGrid(MainForm, MainGrid);
end;

procedure TMainForm.FormResize(Sender: TObject);
begin
  TDrawingUtils.ResizeGrid(MainForm, MainGrid);
end;

procedure TMainForm.MainGridSelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
begin
    StatusBar1.SimpleText := Format('Selected cell: (%d, %d)', [MainGrid.Row, MainGrid.Col]);
end;

end.
