export class TurnQueue<T> {
    private q: T[];
    constructor(){
        this.q = [];
    }

    push(val: T){
        this.q.push(val);
    }

    pop(): T {
        let v = this.q.shift();
        if(v == undefined){
            throw new Error("Popping when the turn queue is empty.");
        }
        return v;
    }

    top(): T {
        let v = this.q[0];
        if(v == undefined){
            throw new Error("Calling top() when the queue is empty.");
        }
        return v;
    }

    clear(): void {
        this.q = [];
    }
}