//
//  ViewController.swift
//  TicTakToe
//
//  Created by Yehia Samak on 10/14/19.
//  Copyright © 2019 Yehia Samak. All rights reserved.
//

import UIKit

class MultiPlayerViewController: UIViewController {

    
    @IBOutlet weak var b1: UIButton!
    @IBOutlet weak var b2: UIButton!
    @IBOutlet weak var b3: UIButton!
    @IBOutlet weak var b4: UIButton!
    @IBOutlet weak var b5: UIButton!
    @IBOutlet weak var b6: UIButton!
    @IBOutlet weak var b7: UIButton!
    @IBOutlet weak var b8: UIButton!
    @IBOutlet weak var b9: UIButton!
    @IBOutlet weak var drawLabel: UILabel!
    @IBOutlet weak var oWinLabel: UILabel!
    @IBOutlet weak var xWinLabel: UILabel!
    
    var computerMode : Bool = true;
    var xWins = 0, oWins = 0, draws = 0;
    var xTurn : Bool  = true;
    let calculator  = TicTacToeCalculator();
    // 0 = empty cell // 1 = x // 2 = o ;
    var myBoard : [[Int]] = [[0, 0, 0],[0, 0, 0],[0, 0, 0]];
    var buttons : [UIButton] = [];
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttons = [b1, b2, b3, b4, b5, b6, b7, b8, b9];
    }
    func disableTheGame(){
             for button in buttons{
                 button.isEnabled = false;
             }
         }
         func reloadTheGame(){
             for button in buttons{
                 button.setBackgroundImage(nil, for: .normal);
                 button.isEnabled = true;
             }
            for i in 0...2{
                for j in 0...2{
                    myBoard[i][j] = 0;
                }
            }
            xTurn = true;
         }

    @IBAction func touchBoard(_ sender: UIButton) {
        let index = sender.tag;
        if(xTurn){
            sender.setBackgroundImage(UIImage(named: "x"), for: .normal);
            myBoard[index/3][index%3] = 1;
            
        }else{
            sender.setBackgroundImage(UIImage(named: "o"), for: .normal);
            myBoard[index/3][index%3] = 2;
        }
        checkState();
       
        sender.isEnabled = false;
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            if(self.computerMode){
                let location = self.calculator.findBestMove(board: &self.myBoard);
            if(location != -1){
                self.buttons[location].setBackgroundImage(UIImage(named: "o"), for: .normal);
                self.buttons[location].isEnabled = false;
                self.myBoard[location/3][location%3] = 2;
                self.checkState();
            }
        }
        
            
          
        }
        
        
    }
    
    @IBAction func reloadButtonClicked(_ sender: Any) {
        reloadTheGame();
    }
    @IBAction func changeMode(_ sender: UISwitch) {
        reloadTheGame();
        computerMode  = !computerMode;
        draws = 0;
        xWins = 0;
        oWins = 0;
        xWinLabel.text = String(xWins);
        oWinLabel.text = String(oWins);
        drawLabel.text = String(draws);
        
    }
    func checkState(){
        let c = calculator.checkWin(board: &myBoard);
        switch c {
        case "x":
            xWins+=1;
            xWinLabel.text = String(xWins);
            disableTheGame();
            showAlert(c: c);
        case "o":
            oWins+=1;
            oWinLabel.text = String(oWins);
            disableTheGame();
            showAlert(c: c);
        case "d":
            draws+=1;
            drawLabel.text = String(draws);
            disableTheGame();
            showAlert(c: c);
        default:
            if(!computerMode){
                xTurn = !xTurn;
            }
        }
    }
    func showAlert(c : Character){
        switch c {
        case "x":
            let alert = UIAlertController(title: "X wins", message: "press on the restart button to play agin", preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "back", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        case "o":
            if(computerMode){
                let alert = UIAlertController(title: "Looooser", message: "play agin 🎉😝", preferredStyle: .actionSheet)
                alert.addAction(UIAlertAction(title: "back", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }else{
                let alert = UIAlertController(title: "o wins", message: "press on the restart button to play agin ", preferredStyle: .actionSheet)
                alert.addAction(UIAlertAction(title: "back", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        case "d":
            let alert = UIAlertController(title: "Its Draw", message: "press on the restart button to play agin ", preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "back", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        default:
            _ = 0;
        }
    }
}

