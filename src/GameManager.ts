import { Board, Piece } from "./Board";
import { GameLogic } from "./GameLogic";
import { Gui } from "./Gui";
import { Move } from "./Move";
import { HumanPlayer, Player, AIPlayer } from "./Player";
import { TurnQueue } from "./TurnQueue";

enum State{
    STATE_BEFORE_GAME,
    STATE_DURING_GAME,
    STATE_AFTER_GAME,
}

export class GameManager {
    
    private b: Board;
    private gl: GameLogic;
    private tq: TurnQueue<Player>;
    private gui: Gui;
    // @ts-expect-error
    private p1: Player; //this will be assigned later
    // @ts-expect-error
    private p2: Player;  //this will be assigned later
    private winner: string;
    private state: State;

    constructor(){
        this.b = new Board();
        this.gl = new GameLogic();
        this.tq = new TurnQueue();
        this.gui = new Gui();
        this.winner = "";
        this.state = State.STATE_BEFORE_GAME;
        this.createMenu();
    }

    createMenu(){
        let startFunc = () => {
            this.restartGame();
        }
        this.state = State.STATE_BEFORE_GAME;
        this.gui.createStartGameGui(startFunc);
    }

    startGame(){
        //we need to get the params from the gui and create our players
        if(this.state == State.STATE_BEFORE_GAME){
            let params = this.gui.getParams();
            this.p1 = (params[1]) ? new AIPlayer(params[0], Piece.Dark, this.b, this.gl) : new HumanPlayer(params[0], Piece.Dark, this.b);
            this.p2 = (params[3]) ? new AIPlayer(params[2], Piece.Light, this.b, this.gl) : new HumanPlayer(params[2], Piece.Light, this.b);
        }else if(this.state == State.STATE_AFTER_GAME){
            //if this happened, that means the user clicked "restart game"
            //in which case we will just reuse our players
        }
        //then we need to place the four starter moves and update the game state
        this.b.acceptMove(new Move(3, 3, Piece.Dark));
        this.b.acceptMove(new Move(4, 4, Piece.Dark));
        this.b.acceptMove(new Move(3, 4, Piece.Light));
        this.b.acceptMove(new Move(4, 3, Piece.Light));
        this.tq.push(this.p1);
        this.tq.push(this.p2);
        this.state = State.STATE_DURING_GAME;
    }

    endGame(){
        let p = this.gl.calculateWinner(this.b);
        if(p == Piece.Nothing){
            this.winner = "Nobody";
        }else{
            this.winner = (p == Piece.Dark) ? "Dark" : "Light";
        }
        this.state = State.STATE_AFTER_GAME;
        //I have to create these callbacks, because if I just pass in this.restartGame, some weird stuff happens with this/self in ts/lua and there is an error
        let restartFunc = () => {
            this.restartGame();
        }
        let mainMenuFunc = () => {
            this.gui.resetGui();
            this.createMenu();
        }
        this.gui.resetGui();
        this.gui.createEndGameGui(restartFunc, mainMenuFunc);
    }

    restartGame(){
        //clear the board and turn queue
        this.b.clearBoard();
        this.tq.clear();
        //use this existing method
        this.startGame();
    }

    update(dt: number){
        switch(this.state){
            case State.STATE_BEFORE_GAME:{
                //we don't need to do anything here.
                break;
            }
            case State.STATE_DURING_GAME:{
                let player = this.tq.top(); //peek at the player who is currently up
                if(!this.gl.canPlayerGo(this.b, player.getColor())){
                    //this player can't go, end turn and add to end of queue
                    this.tq.push(this.tq.pop());
                    //to prevent an infinite loop with players bouncing back their turns, we need to check if the game is over
                    if(this.gl.isGameOver(this.b)){
                        this.endGame();
                    }
                    break;
                }
                let m = player.play();
                let results = this.gl.simulateMove(this.b, m);
                if(results.length == 0){
                    //invalid move, probably due to a human player clicking somewhere invalid
                    break;
                }
                //accept all the moves.
                results.forEach(move => {
                    this.b.acceptMove(move);
                });
                this.tq.push(this.tq.pop()); //end our turn and add to the end of the queue.
                if(this.gl.isGameOver(this.b)){
                    this.endGame();
                }
            }
            case State.STATE_AFTER_GAME:{
                //we don't need to do anything here.
                break;
            }
        }
    }

    private drawGameState(){
        let x = 0;
        let y = 8*this.b.tileSize; //8*tileSize because the board is 8 tiles tall
        switch(this.state){
            case State.STATE_BEFORE_GAME:{
                love.graphics.print("Game not started yet.", x, y);
                break;
            }
            case State.STATE_AFTER_GAME:{
                love.graphics.print(`Game Over! ${this.winner} is the winner.`, x, y);
                break;
            }
            case State.STATE_DURING_GAME:{
                love.graphics.print(`Player ${this.tq.top().getName()}'s turn.`, x, y);
                let scores = this.gl.calculateScore(this.b);                
                love.graphics.print([[1, 1, 1, 1], "Score: ", [0, 0, 0, 1], `${scores[0]} `, [1, 1, 1, 1], `${scores[1]}`], x, y+30);
                break;
            }
        }
    }

    draw(){
        switch(this.state){
            case State.STATE_BEFORE_GAME:{
                this.gui.draw();
                break;
            }
            case State.STATE_DURING_GAME:{
                this.drawGameState();
                this.b.draw();
                break;
            }
            case State.STATE_AFTER_GAME:{
                this.gui.draw();
                this.b.draw();
                this.drawGameState();
                break;
            }
        }
    }
    
    mousePressed(x: number, y: number, button: number){
        this.gui.mousePressed(x, y, button); //call it on our gui;
    }
}