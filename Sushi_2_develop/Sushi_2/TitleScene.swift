//
//  GameScene.swift
//  Sushi_2
//
//  Created by Ryusei Kakubari on 2015/10/05.
//  Copyright (c) 2015年 stella. All rights reserved.
//

import SpriteKit

class TitleScene: SKScene {
    
    
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        backgroundColor = UIColor.blackColor();
        
        /*
            Show a GametitleLabel
        */
        
        let GametitleLabel = SKLabelNode(fontNamed: "Chalkduster");
        GametitleLabel.text = "Sushi_2 sample";
        GametitleLabel.fontSize = 45;
        GametitleLabel.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame));
        
        self.addChild(GametitleLabel);
        
        
        /*
            Show a StartLabel
        */
        
        let StartLabel = SKLabelNode(fontNamed: "Copperplate");
        StartLabel.text = "Start";
        StartLabel.fontSize = 36;
        StartLabel.position = CGPoint(x: CGRectGetMidX(self.frame), y: 200);
        self.addChild(StartLabel);
        
        
        
        
        
        
    }

    
    /*
        When player tap the StartLabel, move to GameScene
    */
    
    /* Occurrence of tap event */
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        
        /* Create a transition destination of scene */
        let newScene = GameScene(size: self.scene!.size);
        
        /* Decide a transition effect of the scene at random */
        let directionNumber = self.GetRandomNumber(Min: 0, Max: 3);
        let directions = [SKTransitionDirection.Down, SKTransitionDirection.Left, SKTransitionDirection.Right, SKTransitionDirection.Up];
        let transitionEffect = SKTransition.revealWithDirection(directions[directionNumber], duration: 1);
        
        /* Adjust the size of the transiton of scene and the present scene */
        newScene.size = self.frame.size;
        
        newScene.scaleMode = SKSceneScaleMode.AspectFit;
        
        /* Move to newScene --> GameScene */
        self.view?.presentScene(newScene, transition: transitionEffect);
    }
    
    /* Get a random number */
    func GetRandomNumber(Min _Min : Int, Max _Max : Int) ->Int {
        return Int(arc4random_uniform(UInt32(_Max)))
    }
    
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
}
