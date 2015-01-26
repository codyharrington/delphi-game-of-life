unit DrawingUtils;

interface

uses
  Vcl.Grids, Vcl.Forms, Vcl.Dialogs, SysUtils, Math;

type
  TAutomataCell = Record
    IsAlive: Boolean;
    Pos: TGridCoord;
  End;

  TDrawingUtils = class
    class procedure ResizeGrid(MainForm: TForm; MainGrid: TDrawGrid);
    class procedure PopulateCellArray(var Cells: Array of TAutomataCell);
    class function StaysAlive(MainGrid: TDrawGrid; Cells: Array of TAutomataCell; CurrentCell: TAutomataCell): Boolean;
    class procedure UpdateCells(MainGrid: TDrawGrid; var Cells: Array of TAutomataCell);
  end;

implementation

class procedure TDrawingUtils.ResizeGrid(MainForm: TForm; MainGrid: TDrawGrid);
begin
  MainGrid.ColCount := Round(MainForm.Width / MainGrid.DefaultColWidth);
  MainGrid.RowCount := Round(MainForm.Height / MainGrid.DefaultRowHeight);
end;

class procedure TDrawingUtils.PopulateCellArray(var Cells: Array of TAutomataCell);
begin
  raise Exception.Create('Not Implemented');
end;

class function TDrawingUtils.StaysAlive(MainGrid: TDrawGrid; Cells: Array of TAutomataCell; CurrentCell: TAutomataCell): Boolean;
var
  Col, Row, _Col, _Row, x, y, LiveCount: Integer;
begin
  x := CurrentCell.Pos.x;
  y := CurrentCell.Pos.y;
  LiveCount := 0;

  for _Col := (x - 1) to (x + 1) do
  begin
    Col := Max(0, Min(MainGrid.ColCount - 1, _Col));

    for _Row := (y - 1) to (y + 1) do
    begin
      Row := Max(0, Min(MainGrid.RowCount - 1, _Row));

      if (Col <> x) and (Row <> y) then
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

class procedure TDrawingUtils.UpdateCells(MainGrid: TDrawGrid; var Cells: Array of TAutomataCell);
var
  Row, Col: Integer;
begin
    raise Exception.Create('Not implemented Error');
end;

end.
