import { Board, Piece } from "./Board";
import { Move } from "./Move";

type Score = [number, number];

export class GameLogic {
    constructor(){
        /* do nothing */
    }

    private canPlaceHere(b: Board, m: Move): boolean {
        return !b.spaceOccupied(m.getRow(), m.getCol());
    }

    private moveWithinBounds(m: Move): boolean {
        let r = m.getRow();
        let c = m.getCol();
        if(r < 0 || r > 7 || c < 0 || c > 7){
            return false;
        }
        return true;
    }

    private nextPosition(direction: number[], m: Move){
        return new Move(m.getRow() + direction[0], m.getCol() + direction[1], m.getColor());
    }

    private simulateAllDirections(b: Board, m: Move): Move[][] {
        // [col, row]
        let directions = [
            [0, -1], //up
            [0, 1], //down
            [-1, 0], //left
            [1, 0], //right
            [-1, -1], //upleft
            [1, -1], //upright
            [-1, 1], //downleft
            [1, 1], //downright
        ];


        let answer: Move[][] = [];


        directions.forEach(dir => {
            let nextMove = this.nextPosition(dir, m);
            let line: Move[] = [];
            let sawEndstone: boolean = false;
            line.push(m);
            while(this.moveWithinBounds(nextMove)){
                let p = b.getPieceAt(nextMove.getRow(), nextMove.getCol());
                if(p == Piece.Nothing){
                    //stop immediately
                    break;
                }
                if(p == m.getColor()){
                    //encountered same color? add and stop immediately
                    line.push(nextMove);
                    sawEndstone = true;
                    break;
                }
                if(p != m.getColor()){
                    //encountered opposite color? add it to the line
                    line.push(nextMove);
                }
                nextMove = this.nextPosition(dir, nextMove);
            }
            if(line.length == 1){
                //not good
                answer.push([]);
            }else if(line.length == 2){
                //not good
                answer.push([]);
            }else{
                if(sawEndstone){
                    answer.push(line);
                }else{
                    answer.push([]);
                }
            }
        });
        return answer;
    }

    //takes in a move, and simulates the resulting changes to the board. an empty list result means the move was invalid.
    simulateMove(b: Board, m: Move): Move[] {
        //let's get rid of wrong moves first:
        if(!this.moveWithinBounds(m)){
            return [];
        }
        if(!this.canPlaceHere(b, m)){
            return [];
        }
        //simulate flipping in all directions:
        let results = this.simulateAllDirections(b, m).flat();
        return results; //an empty list means that the move was invalid.
    }

    public canPlayerGo(b: Board, p: Piece){
        for(let row=0; row<8; row++){
            for(let col=0; col<8; col++){
                if(!b.spaceOccupied(row, col)){ //if this is an open space
                    let results = this.simulateMove(b, new Move(row, col, p)); //simulate the move
                    if(results.length != 0){ //if we find at least one move that works,
                        return true; //this player can go.
                    }
                }
            }
        }
        return false; //if we made it through the whole board without returning true, then this player can't go.
    }

    public isBoardFull(b: Board){
        for(let row=0; row<8; row++){
            for(let col=0; col<8; col++){
                if(!b.spaceOccupied(row, col)){
                    return false; //if we find at least one space that isn't occupied..
                }
            }
        }
        return true;
    }

    public calculateScore(b: Board): Score {
        let darkCount = 0;
        let lightCount = 0;
        for(let row=0; row<8; row++){
            for(let col=0; col<8; col++){
                let p = b.getPieceAt(row, col);
                if(p == Piece.Nothing) { continue }
                (p == Piece.Dark) ? darkCount++ : lightCount++;
            }
        }
        return [darkCount, lightCount];
    }

    isGameOver(b: Board): boolean {
        return (this.isBoardFull(b) || (!this.canPlayerGo(b, Piece.Dark) && !this.canPlayerGo(b, Piece.Light)));
    }

    

    calculateWinner(b: Board): Piece {
        let darkCount = 0;
        let lightCount = 0;
        for(let row=0; row<8; row++){
            for(let col=0; col<8; col++){
                let p = b.getPieceAt(row, col);
                if(p == Piece.Nothing){ continue }
                (p == Piece.Dark) ? darkCount++ : lightCount++;
            }
        }
        //print(`Dark:Light ${darkCount}:${lightCount}`);
        if(darkCount == lightCount){ return Piece.Nothing }
        return (darkCount > lightCount) ? Piece.Dark : Piece.Light;
        
    }

    

}