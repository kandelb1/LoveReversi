import { GameManager } from "./GameManager";
import { Test } from "./Test";

let gm: GameManager;

let runTests = () => {
    let t = new Test();
    t.runTests();
    print("Quitting...");
    love.event.quit();
}

love.load = (arg: string[]) => {
    //parse args for --test
    for(let i = 0; i<arg.length; i++){
        let argument = arg[i].trim();
        if(argument == "--test"){
            runTests();
        }
    }
    love.graphics.setBackgroundColor(0.16, 0.6, 0.14); //green
    love.graphics.setFont(love.graphics.newFont(20));
    gm = new GameManager();
}

love.update = (dt: number) => {
   gm.update(dt);
}

love.draw = () => {
   gm.draw();
}

love.mousepressed = (x: number, y: number, button:number, isTouch:boolean) => {
    gm.mousePressed(x, y, button);
}

