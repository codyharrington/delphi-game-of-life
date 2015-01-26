unit DrawingUtils;

interface

uses
  Vcl.Grids, Vcl.Forms, Vcl.Dialogs, SysUtils;

type
  TAutomataCell = Record
    IsAlive: Boolean;
    Pos: TGridCoord;
  End;

  TDrawingUtils = class
    class procedure ResizeGrid(MainForm: TForm; MainGrid: TDrawGrid);
    class procedure UpdateCellGrid(MainGrid: TDrawGrid);
    class function StaysAlive(Cells: Array of TAutomataCell; CurrentCell: TAutomataCell): Boolean;
    class procedure CheckBoard(Cells: Array of TAutomataCell);
  end;

implementation

class procedure TDrawingUtils.ResizeGrid(MainForm: TForm; MainGrid: TDrawGrid);
begin
  MainGrid.ColCount := Round(MainForm.Width / MainGrid.DefaultColWidth);
  MainGrid.RowCount := Round(MainForm.Height / MainGrid.DefaultRowHeight);
end;

class procedure TDrawingUtils.UpdateCellGrid(MainGrid: TDrawGrid);
begin
  raise Exception.Create('Not Implemented');
end;

class function TDrawingUtils.StaysAlive(Cells: Array of TAutomataCell; CurrentCell: TAutomataCell): Boolean;
var
  Col, Row, x, y, LiveCount: Integer;
begin
  x := CurrentCell.Pos.x;
  y := CurrentCell.Pos.y;
  LiveCount := 0;

  for Col := (x - 1) to (x + 1) do
  begin
    for Row := (y - 1) to (y + 1) do
    begin
      if (Col <> x) and (x >= 0) and (Row <> y) and (y >= 0) then
      begin
        if Cells[Row, Col].IsAlive then
          LiveCount := LiveCount + 1;
        if LiveCount > 3 then
        begin
          Result := False;
          Exit;
        end;
      end;
    end;
  end;

  if LiveCount < 2 then
    Result := False
  else
    Result := True
end;

class procedure TDrawingUtils.CheckBoard(Cells: Array of TAutomataCell);
begin
  raise Exception.Create('Not implemented Error');
end;

end.
