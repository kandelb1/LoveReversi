import { Image } from "love.graphics";

class Button{

    private x: number;
    private y: number;
    private width: number;
    private height: number; 

    private callback: any;

    constructor(x: number, y: number, width: number, height: number, callback?: any){
        this.x = x;
        this.y = y;
        this.width = width;
        this.height = height;
        this.callback = callback;
    }

    draw(){

        love.graphics.setColor(1, 0, 0, 1); //red
        love.graphics.rectangle("fill", this.x, this.y, this.width, this.height);
    }

    mousePressed(x: number, y:number, button: number){
        if(button == 1){
            if(
                x >= this.x &&
                x <= this.x + this.width &&
                y >= this.y &&
                y <= this.y + this.height
            ){
                if(this.callback){
                    this.callback();
                }
            }
        }
    }

}

//we already have the ColouredText type from love, but for some reason, it gives errors.
type ColorText = [number, number, number, number];

class Label{

    private x: number;
    private y: number;
    private text: string;
    private color: ColorText
    

    constructor(x: number, y: number, t: string, color: ColorText){
        this.x = x;
        this.y = y;
        this.text = t;
        this.color = color;
    }

    draw(){
        love.graphics.setColor(1, 1, 1, 1); //reset the color to white.
        love.graphics.print([this.color, this.text], this.x, this.y);
    }
}

class Checkbox{

    private x: number;
    private y: number;
    private p: string;
    private width: number;
    private height: number;
    private checked: boolean;

    private checkmark: Image;

    constructor(x: number, y: number, p: string, checked: boolean){
        this.x = x;
        this.y = y;
        this.p = p;
        this.width = 30;
        this.height= 30;
        this.checked = checked;
        this.checkmark = love.graphics.newImage("smallcheck.png"); //remember that these files are .lua files in the "build" directory
    }

    getPlayer(): string {
        return this.p;
    }

    getChecked(): boolean {
        return this.checked;
    }

    mousePressed(x: number, y:number, button: number){
        if(button == 1){
            if(
                x >= this.x &&
                x <= this.x + this.width &&
                y >= this.y &&
                y <= this.y + this.height
            ){
                this.checked = !this.checked;
            }
        }
    }

    draw(){
        love.graphics.rectangle("line", this.x, this.y, this.width, this.height);
        if(this.checked){
            love.graphics.draw(this.checkmark, this.x, this.y, 0, 0.15, 0.15);
        }
    }
}

class TextInput{
    
    private x: number;
    private y: number;
    private text: string;

    constructor(x: number, y: number){
        this.x = x;
        this.y = y;
        this.text = "";
    }


    mousePressed(x: number, y: number, button: number){
        if(button == 1){
            
        }
    }

    draw(){
        love.graphics.setColor(1, 1, 1, 1); //set to white
        love.graphics.print(this.text, this.x, this.y);
    }
}

export class Gui{
    
    private drawables: any[];
    private clickables: any[];

    // private startCallback: any;

    constructor(){
        this.drawables = [];
        this.clickables = [];
        // this.startCallback = startCallback;
    }

    createStartGameGui(startCallback: any){
        let labelP1 = new Label(0, 50, "Player 1:", [0, 0, 0, 1]);
        this.drawables.push(labelP1);
        let labelP2 = new Label(0, 95, "Player 2:", [1, 1, 1, 1]);
        this.drawables.push(labelP2);
        let labelName = new Label(120, 10, "Name", [1, 1, 0, 1]);
        this.drawables.push(labelName);
        let labelAI = new Label(250, 10, "AI Player?", [1, 1, 0, 1]);
        this.drawables.push(labelAI);
        let check1 = new Checkbox(275, 50, "p1", false);
        this.drawables.push(check1);
        this.clickables.push(check1);
        let check2 = new Checkbox(275, 95, "p2", true);
        this.drawables.push(check2);
        this.clickables.push(check2);
        let startButton = new Button(155, 435, 126, 40, startCallback);
        this.drawables.push(startButton);
        this.clickables.push(startButton);
        let startLabel = new Label(160, 442, "Start Game", [1, 1, 1, 1]);
        this.drawables.push(startLabel);

        //placeholder names for the players
        let nameP1 = new Label(120, 50, "Ben", [0, 0, 0, 1]);
        this.drawables.push(nameP1);
        let nameP2 = new Label(120, 95, "Neb", [1, 1, 1, 1]);
        this.drawables.push(nameP2);
    }

    createEndGameGui(restartCallback: any, mainMenuCallback: any){
        let restartButton = new Button(0, 435, 138, 40, restartCallback);
        this.drawables.push(restartButton);
        this.clickables.push(restartButton);
        let restartLabel = new Label(0, 442, "Restart Game", [1, 1, 1, 1]);
        this.drawables.push(restartLabel);
        let menuButton = new Button(145, 435, 138, 40, mainMenuCallback);
        this.drawables.push(menuButton);
        this.clickables.push(menuButton);
        let menuLabel = new Label(158, 442, "Main Menu", [1, 1, 1, 1]);
        this.drawables.push(menuLabel);
    }


    resetGui(){
        this.drawables = [];
        this.clickables = [];
    }

    draw(){
        this.drawables.forEach(element => {
            element.draw();
        });
    }

    mousePressed(x: number, y: number, button: number){
        this.clickables.forEach(element => {
            element.mousePressed(x, y, button);
        });
    }

    getParams(): [string, boolean, string, boolean] {
        let nameP1 = "Ben";
        let nameP2 = "Neb";
        let humanP1 = true; //default value
        let humanP2 = false; //default value
        this.clickables.forEach(element => {
            if(element.getPlayer){
                if(element.getPlayer() == "p1"){
                    humanP1 = element.getChecked();
                }else if(element.getPlayer() == "p2"){
                    humanP2 = element.getChecked();
                }
            }
        });
        return [nameP1, humanP1, nameP2, humanP2];
    }

}