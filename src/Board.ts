import { isEffectsSupported } from "love.audio";
import { Move } from "./Move";

export enum Piece {
    Nothing,
    Dark,
    Light
}

export class Board {
    private board: Piece[][];
    public tileSize: number;

    constructor(){
        this.tileSize = 50;
        this.board = this.createBoard();
    } 

    private createBoard(): Piece[][] {
        let b: Piece[][] = [];
        for(let row=0; row<8; row++){
            let r: Piece[] = [];
            for(let col=0; col<8; col++){
                r.push(Piece.Nothing);
            }
            b.push(r);
        }
        return b;
    }

    private drawBoardAndPieces(): void {

        //useful when drawing the pieces
        let halfsize = this.tileSize / 2;
        let circleradius = 0.4*this.tileSize;

        for(let row=0; row<8; row++){
            for(let col=0; col<8; col++){
                //draw the tile:
                love.graphics.setColor(1, 1, 1);
                love.graphics.rectangle("line", row*this.tileSize, col*this.tileSize, this.tileSize, this.tileSize);
                //draw the piece (if there is one):
                let cell = this.board[row][col];
                if(cell == Piece.Nothing){
                    //do nothing
                }else if(cell == Piece.Dark){
                    love.graphics.setColor(0,0,0);
                    //so the x,y coordinates of the top left of each tile is (row*tileSize) and (col*tileSize) respectively
                    //thats how we draw them. drawing squares starts at the top left corner.
                    //drawing circles is different because the center of the circle are what the x and y coords refer to
                    //so we just need to do math to get the x,y coords of the center of each tile. easy...a lot of explanation for that
                    love.graphics.circle("fill", (row*this.tileSize) + halfsize, (col*this.tileSize) + halfsize, circleradius);
                    love.graphics.setColor(1,1,1); //back to white
                }else if(cell == Piece.Light){
                    love.graphics.setColor(1,1,1);
                    love.graphics.circle("fill", (row*this.tileSize) + halfsize, (col*this.tileSize) + halfsize, circleradius);
                }else{
                    throw new Error("Found a piece on the board that I didn't recognize.");
                }
            }
        }
    }

    //acceptMove doesn't check to make sure this movie is valid. That's GameLogic's job.
    //But we'll still check our row and col to make sure we don't access something outside of our array
    //Even if we didn't check, it wouldn't cause an error, because lua tables are weird
    //but I consider it bad so we will throw an error.

    private goodCoords(x: number, y: number): boolean {
        if(x < 0 || x > 7 || y < 0 || y > 7){
            return false;
        }
        return true;
    }

    acceptMove(m: Move): void {
        let r = m.getRow();
        let c = m.getCol();
        if(this.goodCoords(r, c)){
            this.board[r][c] = m.getColor();
        }else{
            throw new Error("acceptMove() is getting bad coords.");
        }
    }
    
    spaceOccupied(x: number, y: number): boolean {
        if(this.goodCoords(x, y)){
            if(this.board[x][y] == Piece.Nothing){
                return false;
            }
            return true;
        }else{
            throw new Error("spaceOccupied() is getting bad coords.");
        }
    }

    getPieceAt(x: number, y: number): Piece {
        if(this.goodCoords(x, y)){
            return this.board[x][y];
        }else{
            throw new Error("getPieceAt() is getting bad coords.");
        }
    }

    clearBoard(): void {
        this.board = this.createBoard();
    }
    
    draw(): void {
        this.drawBoardAndPieces();
    }
}