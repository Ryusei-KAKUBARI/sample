//
//  GameScene.swift
//  Sushi_2
//
//  Created by Ryusei Kakubari on 2015/10/05.
//  Copyright © 2015年 stella. All rights reserved.
//

import UIKit
import SpriteKit
import AVFoundation

class GameScene: SKScene {
    
    /* Play time */
    var startDate = NSDate();
    var playtime : CFTimeInterval = 0.0;
    var acceleration : CGFloat = 0.0;
    var base_score : Int = 0;
    let SpeedupLabel = SKLabelNode(fontNamed: "Superclarendon-Bold");
    
    /* Prapare last */
    var last: CFTimeInterval!;
    
    /* Prepare the score */
    
    var score: Int = 0;
    var missPoint: Int = 0;
    
    /* Hide Action */
    private var HideAction: SKAction!;
    
    /* Score Label */
    let ScoreLabel = SKLabelNode(fontNamed: "Copperplate");
    
    /* Continuation condition */
    let MissLabel = SKLabelNode(fontNamed: "Copperplate");
    
    /* About Character */
        /* Rabbit */
    let Rabbit_usually = SKSpriteNode(imageNamed: "Rabbit_usually.png");
    let Rabbit_shock = SKSpriteNode(imageNamed: "Rabbit_shock.png");
    let Rabbit_happy = SKSpriteNode(imageNamed: "Rabbit_happy.png");
    let Rabbit_sad = SKSpriteNode(imageNamed: "Rabbit_sad.png");
    var RabbitNumber: Int = 0;
    private var PresentRabbit: SKSpriteNode!;
        /* Bear */
    let Bear_usually = SKSpriteNode(imageNamed: "Bear_usually.png");
    let Bear_shock = SKSpriteNode(imageNamed: "Bear_shock.png");
    let Bear_happy = SKSpriteNode(imageNamed: "Bear_happy.png");
    let Bear_sad = SKSpriteNode(imageNamed: "Bear_sad.png");
    var BearNumber: Int = 0;
    private var PresentBear: SKSpriteNode!;
    
    /* About dish */
    let Dish_1 = SKSpriteNode(imageNamed: "Dish");
    let Dish_2 = SKSpriteNode(imageNamed: "Dish");
    let Dish_3 = SKSpriteNode(imageNamed: "Dish");
    let Dish_4 = SKSpriteNode(imageNamed: "Dish");
    let Dish_5 = SKSpriteNode(imageNamed: "Dish");
    let Dish_6 = SKSpriteNode(imageNamed: "Dish");
    let Dish_7 = SKSpriteNode(imageNamed: "Dish");
    let Dish_8 = SKSpriteNode(imageNamed: "Dish");
    let Dish_9 = SKSpriteNode(imageNamed: "Dish");
    let Dish_10 = SKSpriteNode(imageNamed: "Dish");
    
    var ate_times : Int = 0;
    var dish_fill : Int = 0;
    var dish_num : Int = 0;
    var clean_sign : Int = 0;
    
    
    /* Put away the dishses */
    let CleanupLabel = SKLabelNode(fontNamed: "Copperplate");
    let Cleanup_shape = SKShapeNode(ellipseInRect: CGRectMake(0, 0, 300, 100));
    
    /* life gauge */
    let lifegauge_1 = SKSpriteNode(imageNamed: "life_carrot");
    let lifegauge_2 = SKSpriteNode(imageNamed: "life_carrot");
    let lifegauge_3 = SKSpriteNode(imageNamed: "life_carrot");
    
    /* speech balloon */
    let speech_balloon_right = SKSpriteNode(imageNamed: "speech_balloon_right");
    private var want_food_Rabbit : SKSpriteNode!;
    let speech_balloon_left = SKSpriteNode(imageNamed: "speech_balloon_left");
    private var want_food_Bear : SKSpriteNode!;
    var character_num : Int = 0;
    
    /*
        Configure of GameScene
    */
    override func didMoveToView(view: SKView) {
    
        /* Configure of Background */
        
        let Background = SKSpriteNode(imageNamed: "Background");
        Background.position = CGPoint(x: self.frame.size.width * 0.5, y: self.frame.size.height * 0.5 - 30);
        Background.zPosition = 0;
        Background.name = "Background";
        self.addChild(Background);
  
        backgroundColor = UIColor.brownColor();
        
        /* Reaction point */
            /* Rabbit */
        let ReactionPoint_Rabbit = SKShapeNode(circleOfRadius: 100);
        ReactionPoint_Rabbit.fillColor = UIColor.whiteColor();
        ReactionPoint_Rabbit.strokeColor = UIColor.clearColor();
        ReactionPoint_Rabbit.position = CGPoint(x: 100, y: 100);
        ReactionPoint_Rabbit.zPosition = 2;
        ReactionPoint_Rabbit.alpha = 0.3;
        self.addChild(ReactionPoint_Rabbit);
            /* Bear */
        let ReactionPoint_Bear = SKShapeNode(circleOfRadius: 100);
        ReactionPoint_Bear.fillColor = UIColor.whiteColor();
        ReactionPoint_Bear.strokeColor = UIColor.clearColor();
        ReactionPoint_Bear.position = CGPoint(x: 1000, y: 100);
        ReactionPoint_Bear.zPosition = 2;
        ReactionPoint_Bear.alpha = 0.3;
        self.addChild(ReactionPoint_Bear);
        
        /* Initialization of ScoreLabel */
        ScoreLabel.text = "SCORE \(score)" ;
        ScoreLabel.fontSize = 50;
        ScoreLabel.position = CGPoint(x: self.frame.size.width, y: self.frame.size.height - 40);
        ScoreLabel.zPosition = 1;
        ScoreLabel.name = "ScoreLabel";
        self.addChild(ScoreLabel);
        
        /* Initialization of character */
        Rabbit_usually.name = "Rabbit_usually";
        Rabbit_shock.name = "Rabbit_shock";
        Rabbit_happy.name = "Rabbit_happy";
        Rabbit_sad.name = "Rabbit_sad";
        
        Bear_usually.name = "Bear_usually";
        Bear_shock.name = "Bear_shock";
        Bear_happy.name = "Bear_happy";
        Bear_sad.name = "Bear_sad";
        
        ShowCharacter();
        
        
        /* Initialization of Dish */
        Dish_1.name = "Dish";
        Dish_2.name = "Dish";
        Dish_3.name = "Dish";
        Dish_4.name = "Dish";
        Dish_5.name = "Dish";
        Dish_6.name = "Dish";
        Dish_7.name = "Dish";
        Dish_8.name = "Dish";
        Dish_9.name = "Dish";
        Dish_10.name = "Dish";
        
        ShowDish();
        
        /* Show lifegauge */
        Show_lifegauge();
        
        /* Show speech balloon */
        speech_balloon_right.position = CGPoint(x: self.frame.size.width * 0.4, y: self.frame
            .size.height * 0.6);
        speech_balloon_right.zPosition = 12;
        speech_balloon_right.alpha = 0.5;
        speech_balloon_right.setScale(0.3);
        self.addChild(speech_balloon_right);
        
        speech_balloon_left.position = CGPoint(x: self.frame.size.width * 0.7 - 30, y: self.frame
            .size.height * 0.6);
        speech_balloon_left.zPosition = 12;
        speech_balloon_left.alpha = 0.5;
        speech_balloon_left.setScale(0.3);
        self.addChild(speech_balloon_left);
        
        Want_food(&character_num);
        
        /* Use timer */
        
            /* CreateThing */
        _ = NSTimer.scheduledTimerWithTimeInterval(0.75, target: self, selector: Selector("update"), userInfo: nil, repeats: true);
            /* Speedup */
        _ = NSTimer.scheduledTimerWithTimeInterval(5.0, target: self, selector: Selector("Speedup"), userInfo: nil, repeats: true);
        
        /* Create the PauseLabel and PauseField */
        
        let PauseLabel = SKLabelNode(fontNamed: "Copperplate");
        PauseLabel.text = "Pause";
        PauseLabel.fontSize = 48;
        PauseLabel.position = CGPoint(x: 30, y: self.frame.size.height - 40);
        PauseLabel.zPosition = 1;
        PauseLabel.name = "Pause";
        self.addChild(PauseLabel);
        
        
        /* CleanupLablel */
        /* Put away the dishes */

        CleanupLabel.text = "Put away!";
        CleanupLabel.fontSize = 40;
        CleanupLabel.position = CGPoint(x: self.frame.size.width * 0.5, y: 240);
        CleanupLabel.zPosition = 20;
        CleanupLabel.hidden = true;
        CleanupLabel.name = "Cleanup";
        self.addChild(CleanupLabel);
        
        Cleanup_shape.fillColor = UIColor.brownColor();
        Cleanup_shape.position = CGPoint(x: self.frame.size.width * 0.5 - 150, y: 200);
        Cleanup_shape.zPosition = 19;
        Cleanup_shape.hidden = true;
        Cleanup_shape.name = "Cleanup";
        self.addChild(Cleanup_shape);
        
        /* SpeedupLabel */
        SpeedupLabel.text = "Speed up!!";
        SpeedupLabel.fontSize = 80;
        SpeedupLabel.fontColor = UIColor.blackColor();
        SpeedupLabel.position = CGPoint(x: self.frame.size.width * 0.5, y: self.frame.size.height * 0.6);
        SpeedupLabel.zPosition = 14;
        SpeedupLabel.hidden = true;
        self.addChild(SpeedupLabel);
    
    }
    
    /*
        Create something (Food, NoFood)
    */
    
    func CreateThing() {
        
        let Tuna = SKSpriteNode(imageNamed: "Tuna");
        Tuna.name = "Eatable_Tuna";
        let Salmon = SKSpriteNode(imageNamed: "Salmon");
        Salmon.name = "Eatable_Salmon";
        let Salmon_roe = SKSpriteNode(imageNamed: "Salmon_roe");
        Salmon_roe.name = "Eatable_Salmon_roe";
        let Egg = SKSpriteNode(imageNamed: "Egg");
        Egg.name = "Eatable_Egg";
        let Apple = SKSpriteNode(imageNamed: "Apple");
        Apple.name = "unEatable";
        let Hedgehog_1 = SKSpriteNode(imageNamed: "Hedgehog_1");
        Hedgehog_1.name = "unEatable";
        let Hedgehog_2 = SKSpriteNode(imageNamed: "Hedgehog_2");
        Hedgehog_2.name = "unEatable";
        
        
        /* The appearance of food (not food) */
    
        let SelectionNumber = self.GetRandomNumber(Min: 0, Max: 4);
        
        if SelectionNumber == 0 {
    
            let NoFoodNumber = self.GetRandomNumber(Min: 0, Max: 3);
            let NoFoods = [Apple, Hedgehog_1, Hedgehog_2];
    
            let NoFood = NoFoods[NoFoodNumber];
            NoFood.position = CGPoint(x: self.frame.maxX + 300, y: 130);
            NoFood.zPosition = 10;
            NoFood.setScale(0.75);
                
            NoFood.physicsBody = SKPhysicsBody(circleOfRadius: 200.200);
            /* Whether is affected by gravity */
            NoFood.physicsBody?.affectedByGravity = false;
            /* Configure of velocity */
            NoFood.physicsBody?.velocity = CGVectorMake(-800 - acceleration, 0);
            /* Ignore air resistance */
            NoFood.physicsBody?.linearDamping = 0;
            self.addChild(NoFood);
    
            } else {
    
            let FoodNumber = self.GetRandomNumber(Min: 0, Max: 4);
            let Foods = [Tuna, Salmon, Salmon_roe, Egg];
               
            let Food = Foods[FoodNumber];
            Food.position = CGPoint(x: self.frame.maxX + 300, y: 130);
            Food.zPosition = 10;
            Food.setScale(0.75);
                
            Food.physicsBody = SKPhysicsBody(circleOfRadius: 200.200);
            /* Whether is affected by gravity */
            Food.physicsBody?.affectedByGravity = false;
            /* Configure of velocity */
            Food.physicsBody?.velocity = CGVectorMake(-800 - acceleration, 0);
            NSLog("velocity=\(Food.physicsBody?.velocity)");
            /* Ignore air resistance */
            Food.physicsBody?.linearDamping = 0;
            self.addChild(Food);
            }
    
    }
    
    /*
        Touch action
    */
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        let touch: AnyObject = touches.first as UITouch!;
        let location = touch.locationInNode(self);
        NSLog("location = \(location)");
        
        /* Acquisition of the touch coordinates */
        let TouchPlace = (location.x, location.y);
        let touchedNode = self.nodeAtPoint(location);
        
        
        NSLog("touchedNode = \(touchedNode)");
        NSLog("\(touchedNode.name)");
        
        if (touchedNode.name != nil) {
            
            if touchedNode.name == "Pause" {
//                MoveScene();
                Tap_PauseLabel();
            }
            
            /* Limited recognition of the touched range */
            switch TouchPlace {
            case (-65.0...275.0, 10.0...160.0) :
                if (touchedNode.name)!.hasPrefix("Eatable") {
                    if dish_fill != 1 {
                        if (touchedNode.name)!.hasSuffix(want_food_Rabbit.name!) {
                            score += 3;
                        } else {
                            score += 1;
                        }
                        NSLog("score = \(score)");
                    }
                    touchedNode.runAction(HideAction);
                    
                    ate_times += 1;
                    ShowDish();
                    
                    if PresentRabbit.name != Rabbit_happy.name {
                        PresentRabbit.hidden = true;
                        PresentRabbit = Rabbit_happy;
                        PresentRabbit.hidden = false;
                            
                    }
                        
                } else if touchedNode.name == "unEatable" {
                    missPoint += 1;
                    AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate));
                    
                    NSLog("missPoint = \(missPoint)");
                    touchedNode.runAction(HideAction);
                    
                    ate_times += 1;
                    ShowDish();
                    
                    if PresentRabbit.name != Rabbit_sad.name {
                        PresentRabbit.hidden = true;
                        PresentRabbit = Rabbit_sad;
                        PresentRabbit.hidden = false;
                    }
                }
                
                want_food_Rabbit.runAction(HideAction);
                character_num = 1;
                Want_food(&character_num);
            
            case (900.0...1100.0, 10.0...160.0) :
                if (touchedNode.name)!.hasPrefix("Eatable") {
                    if dish_fill != 1 {
                        if (touchedNode.name)!.hasSuffix(want_food_Bear.name!) {
                            score += 3;
                        } else {
                            score += 1;
                        }
                        NSLog("score = \(score)");
                    }
                    touchedNode.runAction(HideAction);
                    
                    ate_times += 1;
                    ShowDish();
                    
                    if PresentBear.name != Bear_happy.name {
                        PresentBear.hidden = true;
                        PresentBear = Bear_happy;
                        PresentBear.hidden = false;
                        
                    }
                    
                } else if touchedNode.name == "unEatable" {
                    missPoint += 1;
                    AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate));
                    
                    NSLog("missPoint = \(missPoint)");
                    touchedNode.runAction(HideAction);
                    
                    ate_times += 1;
                    ShowDish();
                    
                    if PresentBear.name != Bear_sad.name {
                        PresentBear.hidden = true;
                        PresentBear = Bear_sad;
                        PresentBear.hidden = false;
                    }
                }
                
                want_food_Bear.runAction(HideAction);
                character_num = 2;
                Want_food(&character_num);
                
                
                
            default :
                if touchedNode.name == "Background" {
                    if PresentRabbit.name != Rabbit_shock.name {
                        PresentRabbit.hidden = true;
                        PresentRabbit = Rabbit_shock;
                        PresentRabbit.hidden = false;
                    }
                    if PresentBear.name != Rabbit_shock.name {
                        PresentBear.hidden = true;
                        PresentBear = Bear_shock;
                        PresentBear.hidden = false;
                    }
                }
                
            }
            
            if PresentRabbit != Rabbit_usually {
                _ = NSTimer.scheduledTimerWithTimeInterval(0.8, target: self, selector: Selector("ReturnRabbit_usually"), userInfo: nil, repeats: false);
            }
            
            if PresentBear != Bear_usually {
                _ = NSTimer.scheduledTimerWithTimeInterval(0.8, target: self, selector: Selector("ReturnBear_usually"), userInfo: nil, repeats: false);
            }

            if touchedNode.name == "Cleanup" {
                clean_sign += 1;
                ShowDish();
                ate_times = 0;
                
                CleanupLabel.hidden = true;
                Cleanup_shape.hidden = true;
                dish_fill = 0;
            }
        }
    }
    
    /*
        Always running
    */
    override func update(currentTime: NSTimeInterval) {
        
        /* HideAction */
        HideAction = SKAction.hide();
        
        /* Update of ScoreLabel */
        ScoreLabel.text = "SCORE \(score)" ;
        
        /* Hide lifegauge */
        if missPoint == 1 {
            lifegauge_1.hidden = true;
        } else if missPoint == 2 {
            lifegauge_2.hidden = true;
        } else if missPoint == 3 {
            lifegauge_3.hidden = true;
            MoveScene();
        }
        
        if dish_fill == 1 {
            let fadeToAlpha1:SKAction = SKAction.fadeAlphaTo(1, duration: 0.5);
            let fadeToAlpha2:SKAction = SKAction.fadeAlphaTo(0.8, duration: 0.5);
            let fadeIn_label:SKAction = SKAction.sequence([fadeToAlpha1]);
            let fadeIn_shape: SKAction = SKAction.sequence([fadeToAlpha2]);
            CleanupLabel.runAction(fadeIn_label);
            Cleanup_shape.runAction(fadeIn_shape);
        }
        
        /* playtime */
        playtime = NSDate().timeIntervalSinceDate(startDate);
//        NSLog("playtime = \(playtime)");
        
    }
    
    
    /*
        Show a Character
    */
    
    func ShowCharacter () {
        
        let Rabbits = [Rabbit_usually, Rabbit_shock, Rabbit_happy, Rabbit_sad];
        
        for RabbitNumber in 0...3 {
            let Rabbit = Rabbits[RabbitNumber];
            Rabbit.position = CGPoint(x: 100, y: 450);
            Rabbit.zPosition = 1;
            self.addChild(Rabbit);
            
            if RabbitNumber == 0 {
                PresentRabbit = Rabbit;
            } else {
                Rabbit.hidden = true;
            }
        }
        
        let Bears = [Bear_usually, Bear_shock, Bear_happy, Bear_sad];
        
        for BearNumber in 0...3 {
        let Bear = Bears[BearNumber];
            Bear.position = CGPoint(x: 1000, y: 450);
            Bear.zPosition = 1;
            self.addChild(Bear);
            
            if BearNumber == 0 {
                PresentBear = Bear;
            } else {
                Bear.hidden = true;
            }
        }

        
    }
        
    /* 
        PresentRabbit -> Rabbit_usually
    */
    func ReturnRabbit_usually () {
        PresentRabbit.hidden = true;
        Rabbit_usually.hidden = false;
        PresentRabbit = Rabbit_usually;
        NSLog("ReturnRabbit_usually");
        
    }
    
    /*
        PresentBear -> Bear_usually
    */
    func ReturnBear_usually () {
        PresentBear.hidden = true;
        Bear_usually.hidden = false;
        PresentBear = Bear_usually;
        NSLog("ReturnBear_usually");
        
    }
    
    /*
        Show dish
    */
    func ShowDish () {

        let dishes_y_left = [230, 260, 290, 320, 350 ,380, 410, 440, 470, 500];
        var dish_y_left : CGFloat;
        let dish_z = [2, 3, 4, 5, 6, 7, 8, 9, 10, 11];
        let dishes = [Dish_1, Dish_2, Dish_3, Dish_4, Dish_5, Dish_6, Dish_7, Dish_8, Dish_9, Dish_10];
        var dish : SKSpriteNode;
        
        /* Configure dishes */
        if missPoint == 0 && score == 0 {
            for dish_num in 0 ... 9 {
                dish = dishes[dish_num];
                dish_y_left = CGFloat (dishes_y_left[dish_num]);
                dish.position = CGPoint(x: self.frame.size.width * 0.5, y: dish_y_left);
                dish.zPosition = CGFloat (dish_z[dish_num]);
                dish.setScale(0.7);
                dish.hidden = true;
                self.addChild(dishes[dish_num]);
            }
        }
        
        /* Put dishes */
        if ate_times != 0 && ate_times <= 10 {
            dish = dishes[ate_times - 1];
            dish.hidden = false;
            
            if ate_times == 10 {
                dish_fill = 1;
                CleanupLabel.hidden = false;
                Cleanup_shape.hidden = false;
            }
        }
        
        /* Put away dishes */
        if clean_sign == 1 {
            for dish_num in 0 ... 9 {
                dish = dishes[dish_num];
                dish.hidden = true;
            }
            clean_sign = 0;
        }
    }
    
    
    /*
        Show lifegauge
    */
    func Show_lifegauge () {
        let lifegauge_array = [lifegauge_3, lifegauge_2, lifegauge_1];
        var lifegauge_number : Int = 0;
        for lifegauge_number in 0 ... 2 {
            let lifegauge = lifegauge_array [lifegauge_number];
            lifegauge.position = CGPoint(x: self.frame.size.width * 0.5 + (CGFloat(100 * lifegauge_number - 100)), y: self.frame.maxY - 25);
            lifegauge.zPosition = 1;
            lifegauge.setScale(0.12);
            self.addChild(lifegauge);
        }
    }
    
    /*
        Move to ResultScene
    */
    func MoveScene () {
        let score_data = NSUserDefaults.standardUserDefaults();
        score_data.setInteger(score, forKey: "score");
        
        let newScene = ResultScene(size: self.scene!.size);
        newScene.scaleMode = SKSceneScaleMode.AspectFill;
        self.view!.presentScene(newScene);

    }
    
    /* 
        Get a randam number
    */
    func GetRandomNumber(Min _Min : Int, Max _Max : Int) ->Int {
        return Int(arc4random_uniform(UInt32(_Max)))
    }
    
    /* 
        Processing to be performed every a second
    */
    
    func update() {
        /* CreateThing */
        let RandomTime = GetRandomNumber(Min: 1, Max: 5);
        switch RandomTime {
        case 1:
            CreateThing();
        case 2:
            CreateThing();
        case 3:
            break;
        case 4:
            CreateThing();
        case 5:
            CreateThing();
        default :
            break;
        }
        
        /* Hide SpeedupLabel */
        if SpeedupLabel.hidden == false {
            SpeedupLabel.hidden = true;
        
        }
    }
    
    /* 
        want food
    */
    func Want_food (inout want_character_num :Int) {
        let Tuna = SKSpriteNode(imageNamed: "Tuna");
        Tuna.name = "Tuna";
        let Salmon = SKSpriteNode(imageNamed: "Salmon");
        Salmon.name = "Salmon";
        let Salmon_roe = SKSpriteNode(imageNamed: "Salmon_roe");
        Salmon_roe.name = "Salmon_roe";
        let Egg = SKSpriteNode(imageNamed: "Egg");
        Egg.name = "Egg";
        
        let want_foods = [Tuna, Salmon, Salmon_roe, Egg];
        let want_character = [want_food_Rabbit, want_food_Bear];
        let want_food_number_R = GetRandomNumber(Min: 0, Max: 4);
        let want_food_number_B = GetRandomNumber(Min: 0, Max: 4);
        
        switch want_character_num {
        case 0:
            want_food_Rabbit = want_foods[want_food_number_R];
            
            want_food_Rabbit.position = CGPoint(x: self.frame.size.width * 0.4, y: self.frame
                .size.height * 0.6);
            want_food_Rabbit.zPosition = 13;
            want_food_Rabbit.alpha = 0.8;
            want_food_Rabbit.setScale(0.5);
            self.addChild(want_food_Rabbit);
            
            want_food_Bear = want_foods[want_food_number_B];
            want_food_Bear.position = CGPoint(x: self.frame.size.width * 0.7 - 30, y: self.frame
                .size.height * 0.6);
            want_food_Bear.zPosition = 13;
            want_food_Bear.alpha = 0.8;
            want_food_Bear.setScale(0.5);
            self.addChild(want_food_Bear);
            
        case 1:
            want_food_Rabbit = want_foods[want_food_number_R];
            want_food_Rabbit.position = CGPoint(x: self.frame.size.width * 0.4, y: self.frame
            .size.height * 0.6);
            want_food_Rabbit.zPosition = 13;
            want_food_Rabbit.alpha = 0.8;
            want_food_Rabbit.setScale(0.5);
            self.addChild(want_food_Rabbit);
            character_num = 0;

            
        case 2:
            want_food_Bear = want_foods[want_food_number_B];
            want_food_Bear.position = CGPoint(x: self.frame.size.width * 0.7 - 30, y: self.frame
                    .size.height * 0.6);
            want_food_Bear.zPosition = 13;
            want_food_Bear.alpha = 0.8;
            want_food_Bear.setScale(0.5);
            self.addChild(want_food_Bear);
            character_num = 0;

        default :
                break;
        }
    }
    
    
    /* 
        Speedup 
    */
    func Speedup () {
        if base_score + 5 <= score {
            
            if score > 5 {
                acceleration += 80;
            } else if score > 50 {
                acceleration += 10;
            } else if score > 100 {
                acceleration += 150;
            }
            
            SpeedupLabel.hidden = false;
            base_score = score;
            NSLog("speedup = \(acceleration)");
            
            
        } else {
            NSLog("Though");
        }
    
    }
    
    /* Tap_PauseLabel */
    func Tap_PauseLabel () {
        let alertController = UIAlertController(title: "Pause", message: "Do you want to continue the game?", preferredStyle: .Alert);
        
        let positive_action = UIAlertAction(title: "Continue", style: .Cancel,  handler: nil);
        
        let negative_action = UIAlertAction(title: "Quit", style: .Default, handler: { (action: UIAlertAction!) -> Void in
            let newscene = TitleScene(size: self.size)
            let TitleScene_transition = SKTransition.fadeWithDuration (NSTimeInterval(1.0))
            self.view?.presentScene(newscene, transition: TitleScene_transition)});
    
        alertController.addAction(positive_action);
        alertController.addAction(negative_action);

        let currentViewController : UIViewController? = UIApplication.sharedApplication().keyWindow?.rootViewController!
        currentViewController?.presentViewController(alertController, animated: true, completion: nil)
        
    }
    
}