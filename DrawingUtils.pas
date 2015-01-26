unit DrawingUtils;

interface

uses
  Vcl.Grids, Vcl.Forms;

type
  TDrawingUtils = class
  class procedure ResizeGrid(MainForm: TForm; MainGrid: TDrawGrid);
  end;

implementation

class procedure TDrawingUtils.ResizeGrid(MainForm: TForm; MainGrid: TDrawGrid);
begin
  MainGrid.ColCount := Round(MainForm.Width / MainGrid.DefaultColWidth);
  MainGrid.RowCount := Round(MainForm.Height / MainGrid.DefaultRowHeight);
end;

end.
