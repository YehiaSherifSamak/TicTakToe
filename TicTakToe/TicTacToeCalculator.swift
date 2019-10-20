//
//  TicTacToeCalculator.swift
//  TicTakToe
//
//  Created by Yehia Samak on 10/15/19.
//  Copyright © 2019 Yehia Samak. All rights reserved.
//

import Foundation
class TicTacToeCalculator{
    func checkWin(board : inout [[Int]])->Character{
        var x : Int = 0;
        var o : Int = 0;
        var empty = false;
        for i in 0...2{
            x = 0;
            o = 0;
            for j in 0...2{
                if(board[i][j] == 1){
                    x+=1;
                }else if(board[i][j] == 2){
                    o+=1;
                }else{
                    empty  = true;
                }
            }
            if(x == 3){
                return "x";
            }else if(o == 3) {
                return "o";
            }
        }
        for j in 0...2{
            x = 0;
            o = 0;
            for i in 0...2{
                if(board[i][j] == 1){
                    x+=1;
                }else if(board[i][j] == 2){
                    o+=1;
                }else{
                    empty  = true;
                }
            }
            if(x == 3){
                return "x";
            }else if(o == 3) {
                return "o";
            }
        }
        x = 0
        o = 0
        for i in 0 ... 2{
           if(board[i][i] == 1){
               x+=1;
           }else if(board[i][i] == 2){
               o+=1;
            }
           if(x == 3){
                return "x";
            }else if(o == 3) {
                return "o";
            }
        }
        x = 0;
        o = 0;
        for i in 0 ... 2{
            if(board[i][2-i] == 1){
                x+=1;
            }else if(board[i][2-i] == 2){
                o+=1;
            }
            if(x == 3){
                return "x";
            }else if(o == 3) {
                return "o";
            }
        }
        if(empty){
            return "p";
        }
        return "d";
    }
//    func isMoveLeft(board : inout [[Int]])->Bool{
//        for i in 0 ... 2{
//            for j in 0 ... 2{
//                if board[i][j] == 0{
//                    return true;
//                }
//            }
//        }
//        return false;
//    }
    var counter = 0;
    var calucaltedValues : [String : Int] = [:];
    func minMax(board : inout [[Int]], depth : Int, isMax: Bool) ->Int{
       // printBoard(board: &board);
        counter += 1;
        let currState : Character  = checkWin(board: &board);
        var score = 0;
        switch currState {
        case "x":
            score = -10 + depth;
            return score ;
        case "o":
            score = 10 - depth;
            return score ;
        case "d":
            return 0;
        default:
            score = 0;
        }
        var best : Int;
        if(isMax){
            best = -1000;
            for i in 0 ... 2{
                for j in 0 ... 2{
                    if(board[i][j] == 0){
                        board[i][j] = 2;
                        best = max(best, minMax(board: &board, depth: depth+1, isMax: false));
                        board[i][j] = 0;
                    }
                }
            }
        }else{
            best = 1000;
            for i in 0 ... 2{
                for j in 0 ... 2{
                    if(board[i][j] == 0){
                        board[i][j] = 1;
                        best = min(best, minMax(board: &board, depth: depth+1, isMax: true));
                        board[i][j] = 0;
                    }
                   
                }
            }
        }
        return best;
    }
    func findBestMove(board: inout [[Int]]) -> Int{
        counter = 0;
        var best : Int = -1000;
        var location = -1, currValue = 0;
        for i in 0 ... 2{
            for j in 0 ... 2{
                if(board[i][j] == 0){
                    board[i][j] = 2;
                    currValue = minMax(board: &board, depth: 1, isMax: false);
                    board[i][j] = 0;
                    if(currValue > best){
                        location  = i * 3 + j;
                        best = currValue;
                    }
                }
            }
        }
        print(String(counter));
        return location;
    }
    func printBoard(board : inout [[Int]]){
        for i in  0...2{
            for j in 0...2{
                print(String(board[i][j]),  terminator: " ");
            }
            print();
        }
        print("--------------------------------")
    }
}
