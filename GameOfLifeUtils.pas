unit GameOfLifeUtils;

interface

uses
  Vcl.Grids, Vcl.Forms, Vcl.Dialogs, SysUtils, Math;

type
  TAutomataCell = Record
    IsAlive: Boolean;
    Pos: TGridCoord;
  End;

  TAutomataCellArray = Array of Array of TAutomataCell;

  TGameOfLifeUtils = class
    class procedure ResizeGrid(MainForm: TForm; MainGrid: TDrawGrid);
    class procedure PopulateCellArray(MainGrid: TDrawGrid; var Cells: TAutomataCellArray);
    class function StaysAlive(MainGrid: TDrawGrid; Cells: TAutomataCellArray; CurrentCell: TAutomataCell): Boolean;
  end;

implementation

class procedure TGameOfLifeUtils.ResizeGrid(MainForm: TForm; MainGrid: TDrawGrid);
begin
  MainGrid.ColCount := Round(MainForm.Width / MainGrid.DefaultColWidth);
  MainGrid.RowCount := Round(MainForm.Height / MainGrid.DefaultRowHeight);
end;

class procedure TGameOfLifeUtils.PopulateCellArray(MainGrid: TDrawGrid; var Cells: TAutomataCellArray);
var
  Col, Row, Rand: Integer;
  WillBeAlive: Boolean;
begin
  SetLength(Cells, MainGrid.RowCount);

  for Row := 0 to MainGrid.RowCount - 1 do
    SetLength(Cells[Row], MainGrid.ColCount);

  for Row := 0 to MainGrid.RowCount - 1 do
  begin
    for Col := 0 to MainGrid.ColCount - 1 do
    begin
      Cells[Row, Col].Pos.X := Col;
      Cells[Row, Col].Pos.Y := Row;
      Rand := Random(2);
      case Rand of
        0:
          Cells[Row, Col].IsAlive := False;
        1:
          Cells[Row, Col].IsAlive := True;
      end;
    end;
  end;
end;

class function TGameOfLifeUtils.StaysAlive(MainGrid: TDrawGrid; Cells: TAutomataCellArray; CurrentCell: TAutomataCell): Boolean;
var
  Col, Row, _Col, _Row, X, Y, LiveNeighbourCount: Integer;
  CurrentlyAlive: Boolean;
begin
  X := CurrentCell.Pos.X;
  Y := CurrentCell.Pos.Y;
  CurrentlyAlive := CurrentCell.IsAlive;
  LiveNeighbourCount := 0;

  for _Col := (X - 1) to (X + 2) do
  begin
    Col := Max(0, Min(MainGrid.ColCount - 1, _Col));
    for _Row := (Y - 1) to (Y + 2) do
    begin
      Row := Max(0, Min(MainGrid.RowCount - 1, _Row));
      if (Col <> X) and (Row <> Y) then
      begin
        if Cells[Row, Col].IsAlive then
          LiveNeighbourCount := LiveNeighbourCount + 1;
        if LiveNeighbourCount > 3 then
        begin
          Result := False;
          Exit;
        end;
      end;
    end;
  end;

  if CurrentlyAlive and (LiveNeighbourCount < 2) then
    Result := False
  else if CurrentlyAlive and (LiveNeighbourCount <= 3) then
    Result := True
  else if not CurrentlyAlive and (LiveNeighbourCount = 3) then
    Result := True
  else
    Result := False
end;

end.
