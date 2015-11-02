//
//  ResultScene.swift
//  Sushi_2
//
//  Created by Ryusei Kakubari on 2015/10/05.
//  Copyright © 2015年 stella. All rights reserved.
//

import SpriteKit

class ResultScene: SKScene {
    
    override func didMoveToView(view: SKView) {
        
        /*
            Keep the score and a best score from the user default
        */
        
        let score_data = NSUserDefaults.standardUserDefaults();
        var score = score_data.integerForKey("score");
        var best_score = score_data.integerForKey("best_score");
        
        /*
            Show the score
        */
    
        let ScoreLabel = SKLabelNode(fontNamed: "Copperplate");
        ScoreLabel.text = "SCORE:\(score)";
        ScoreLabel.fontSize = 72;
        ScoreLabel.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame));
        
        self.addChild(ScoreLabel);
        
        /*
            When the score is higher than the best_score, update the best_score
        */
        
        if score > best_score {
            score_data.setInteger(score, forKey: "best_score");
            best_score = score;
            
        }
        
        /*
            Show the best_score
        */
        
        let bestscore = SKLabelNode(fontNamed: "Copperplate");
        bestscore.text = "過去最高得点:\(best_score)";
        bestscore.fontSize = 36;
        bestscore.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame)-100);
        
        self.addChild(bestscore);
     
        /*
            Create the BackLabel to return
        */
        
        let BackLabel = SKLabelNode(fontNamed: "Copperplate");
        BackLabel.text = "Back";
        BackLabel.fontSize = 36;
        BackLabel.position = CGPoint(x: CGRectGetMidX(self.frame), y: 200);
        BackLabel.name = "Back";
        
        self.addChild(BackLabel);
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        let touch: AnyObject = touches.first as UITouch!;
        let location = touch.locationInNode(self);
        let touchedNode = self.nodeAtPoint(location);
        
        if (touchedNode.name != nil) {
            
            if touchedNode.name == "Back" {
                
                let newScene = TitleScene(size: self.scene!.size);
                newScene.scaleMode = SKSceneScaleMode.AspectFill;
                self.view!.presentScene(newScene);
                
            }
            
        }
    }
    
    override func update(currentTime: NSTimeInterval) {
        
    }
    
}
