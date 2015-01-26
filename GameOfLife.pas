unit GameOfLife;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.ExtCtrls, DrawingUtils;

type
  TMainForm = class(TForm)
    MainGrid: TDrawGrid;
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
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


end.
