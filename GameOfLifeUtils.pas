unit GameOfLifeUtils;

interface

uses
  Vcl.Grids, Vcl.Forms, Vcl.Dialogs, SysUtils, Vcl.Graphics, Math;

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
    class procedure GenocideCells(MainGrid: TDrawGrid; var Cells: TAutomataCellArray);
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
  Col, Row, X, Y, XMin, XMax, YMin, YMax, LiveNeighbourCount: Integer;
  CurrentlyAlive: Boolean;
begin
  X := CurrentCell.Pos.X;
  Y := CurrentCell.Pos.Y;
  CurrentlyAlive := CurrentCell.IsAlive;
  LiveNeighbourCount := 0;

  XMin := Max(0, X - 1);
  XMax := Min(X + 1, MainGrid.ColCount - 1);
  YMin := Max(0, Y - 1);
  YMax := Min(Y + 1, MainGrid.RowCount - 1);

  for Row := YMin to YMax do
  begin
    for Col := XMin to XMax do
    begin
      if (Row <> Y) or (Col <> X) then
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

  case CurrentlyAlive of
    True:
      begin
        if LiveNeighbourCount < 2 then
          Result := False
        else
          Result := True
      end;
    False:
      begin
        if LiveNeighbourCount = 3 then
          Result := True
        else
          Result := False
      end;
  end;
end;

class procedure TGameOfLifeUtils.GenocideCells(MainGrid: TDrawGrid; var Cells: TAutomataCellArray);
var
  Col, Row: Integer;
begin
  for Row := 0 to MainGrid.RowCount - 1 do
  begin
    for Col := 0 to MainGrid.ColCount - 1 do
    begin
      Cells[Row, Col].IsAlive := False;
      MainGrid.Canvas.Brush.Color := clWhite;
      MainGrid.Canvas.FillRect(MainGrid.CellRect(Col, Row));
    end;
  end;
end;

end.
