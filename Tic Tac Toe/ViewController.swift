//
//  ViewController.swift
//  Tic Tac Toe
//
//  Created by Caksu Sethi on 13/03/21.
//

import UIKit
import AVFoundation
class ViewController: UIViewController {

    // MARK: - IBoutlets
    @IBOutlet weak var btnPlayOutlet: UIButton!
    @IBOutlet weak var vwMain: UIView!
    @IBOutlet weak var lblWin: UILabel!
    
    // MARK: - Properties
    var gameIsActive  = true
    var count = 1
    var activePlayer = 1 //Cross
    var gameState  = [0,0,0,0,0,0,0,0,0]
    let wining = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[2,4,6]]
    var pianoSound = NSURL(fileURLWithPath: Bundle.main.path(forResource: "tone", ofType: "mp3")!)
      var audioPlayer = AVAudioPlayer()
    
    // MARK: - ViewlifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lblWin.text = ""
        /*let v = CustomView()
        v.frame = CGRect(x: vwMain.frame.minX, y: vwMain.frame.minY, width: 100, height: vwMain.frame.height)
            //CGRectMake(100, 100, 100, 200)
        v.layer.borderWidth = 1
        view.addSubview(v)*/
    }
    
    // MARK: - IBActions
    @IBAction func btnAction(_ sender: UIButton) {
        if lblWin.text != nil || lblWin.text == "" {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: pianoSound as URL)
                audioPlayer.play()
            } catch {
                print("ERROR")
                // couldn't load file :(
            }
            if gameState[sender.tag - 1] == 0 && gameIsActive == true {
                gameState[sender.tag - 1] = activePlayer
                if activePlayer == 1 {
                    
                    sender.tintColor = .red
                    sender.setImage(#imageLiteral(resourceName: "imgClose"), for: .normal)
                    activePlayer = 2
                    //audioPlayer.stop()
                } else {
                    sender.tintColor = .blue
                    
                    sender.setImage(#imageLiteral(resourceName: "imgCircle"), for: .normal)
                    activePlayer = 1
                    //audioPlayer.stop()
                }
            }
            print("GAME",gameState)
            for com  in wining {
                if gameState[com[0]] != 0 &&  gameState[com[0]] ==  gameState[com[1]]   &&  gameState[com[1]] ==   gameState[com[2]] {
                    gameIsActive = false
                    print("Wining",com[1])
                    
                    if gameState[com[0]] == 1 {
                        lblWin.text = "CROSS HAS WON!"
                    } else {
                        lblWin.text = "CIRCLE HAS WON!"
                    }
                } else {
                    
                    print("Fail",com)
                }
            }
        }
    }
   
    @IBAction func btnPlayAgain(_ sender: Any) {
        activePlayer = 1 //Cross
        gameState  = [0,0,0,0,0,0,0,0,0]
        gameIsActive  = true
        for i in 1...9 {
            let btn = view.viewWithTag(i) as? UIButton
            btn?.setImage(nil, for: .normal)
            self.lblWin.text = ""
        }
    }
}

