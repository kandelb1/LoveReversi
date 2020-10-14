import { Board, Piece } from "./Board";
import { GameLogic } from "./GameLogic";
import { Move } from "./Move";

export class Test{

    constructor(){
        //nothing
    }

    private printMoveList(moves: Move[]): void {
        print("--");
        for(let i = 0; i<moves.length; i++){
            let r = moves[i].getRow();
            let c = moves[i].getCol();
            let color: string;
            let p = moves[i].getColor();
            if(p == Piece.Nothing){
                color = "Nothing";
            }else if(p == Piece.Dark){
                color = "Dark";
            }else if(p == Piece.Light){
                color = "Dark";
            }else{
                throw new Error("What");
            }
            print(" ".repeat(i+1) + `Row:Col:Color ${r}:${c}:${color}`);
        }
        print("--");
    }

    
    private testGameLogic(){
        let gl = new GameLogic();

        function testFlipping(pml: any){
            let b = new Board();

            /*
                Light
                +Dark
                Returns
                []
            */
            b.acceptMove(new Move(0, 0, Piece.Light));
            let result = gl.simulateMove(b, new Move(0, 1, Piece.Dark));
            assert(result.length == 0, "test 1");
            /*
                Light
                Light
                +Dark
                Returns
                []
            */
            b = new Board();
            b.acceptMove(new Move(0, 0, Piece.Light));
            b.acceptMove(new Move(0, 1, Piece.Light));
            result = gl.simulateMove(b, new Move(0, 2, Piece.Dark));
            
            assert(result.length == 0, "test holy shit");
            /*
                Dark
                Light
                +Dark
                Returns
                Dark
                Dark
                Dark
            */
            b.acceptMove(new Move(0, 0, Piece.Dark));
            b.acceptMove(new Move(0, 1, Piece.Light));
            result = gl.simulateMove(b, new Move(0, 2, Piece.Dark))
            assert(result.length == 3, "test 2");
            result.forEach(move => {
                assert(move.getColor() == Piece.Dark);
            });
            /*
                Dark
                Light
                +Light
                Returns
                []
            */
            result = gl.simulateMove(b, new Move(0, 2, Piece.Light));
            // pml(result);
            assert(result.length == 0, "test 3");
            /*
                Dark
                Light
                Light
                +Dark
                Returns
                Dark
                Dark
                Dark
                Dark
            */
           b.acceptMove(new Move(0, 2, Piece.Light));
           result = gl.simulateMove(b, new Move(0, 3, Piece.Dark));
           assert(result.length == 4, "test 4");
           result.forEach(move => {
               assert(move.getColor() == Piece.Dark);
           });
        }

        //this tests flipping in all directions because the code is identical
        testFlipping(this.printMoveList);
    }

    runTests(){
        //run them
        print("Running tests...");
        this.testGameLogic();
        print("All tests good!");
    }

    draw(){
        
    }

}