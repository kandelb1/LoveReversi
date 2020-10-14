import { Board, Piece } from "./Board";
import { GameLogic } from "./GameLogic";
import { Move } from "./Move";

export abstract class Player{
    protected name: string;
    protected color: Piece;
    protected b: Board;
    
    constructor(name: string, color: Piece, b: Board){
        this.name = name;
        this.color = color;
        this.b = b;
    }

    getColor(): Piece {
        return this.color;
    }

    getName(): string { 
        return this.name;
    }

    abstract play(): Move;
}

export class HumanPlayer extends Player{

    constructor(name: string, color: Piece, b: Board){
        super(name, color, b);
    }
    
    play(): Move {
        if(love.mouse.isDown(1)){
            let xCoord = Math.floor(love.mouse.getX() / this.b.tileSize);
            let yCoord = Math.floor(love.mouse.getY() / this.b.tileSize);
            if(xCoord >= 0 && xCoord <= 7 && yCoord >= 0 && yCoord <= 7){                
                return new Move(xCoord, yCoord, this.color);
            }
        }
        return new Move(-1, -1, this.color); //intentionally return an invalid move because the human player is not clicking down right now.
    }
}

export class AIPlayer extends Player {

    private gl: GameLogic;
    constructor(name: string, color: Piece, b: Board, gl: GameLogic){
        super(name, color, b);
        this.gl = gl;
    }

    play(): Move {
        //the ai will find the move that results in the most flips to their color.
        //if there are multiple equal moves, it randomly chooses one.
        love.timer.sleep(0.25); //sleep so the AI player doesn't play instantly
        let theMoves = [new Move(-1, -1, this.color)]; //initial starting array
        let theScore = -1; //initial starting score
        
        for(let row=0; row<8; row++){
            for(let col=0; col<8; col++){
                let m = new Move(row, col, this.color);
                let results = this.gl.simulateMove(this.b, m);
                let l = results.length;
                if(l == theScore){ //if we found a move of equal value,
                    theMoves.push(m); //add it to our list
                }else if(l > theScore){ //if we found a move of better value,
                    theMoves = []; //clear the list and add that move
                    theMoves.push(m);
                    theScore = l; //update the highest score we have so far
                }
            }
        }
        let index = Math.floor(love.math.random() * theMoves.length); //using love.math.random() because it is seeded
        return theMoves[index];
    }
}