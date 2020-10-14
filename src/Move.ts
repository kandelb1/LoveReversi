import { Piece } from "./Board";


export class Move{
    private x: number;
    private y: number;
    private color: Piece;
    
    constructor(x: number, y: number, color: Piece){
        this.x = x
        this.y = y;
        this.color = color;
    }

    getRow(): number {
        return this.x;
    }

    getCol(): number {
        return this.y;
    }

    getColor(): Piece {
        return this.color;
    }

}

