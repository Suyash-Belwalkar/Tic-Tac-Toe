//
//  ContentView.swift
//  Tic-Tac-Toe
//
//  Created by Suyash on 22/04/25.
//

import SwiftUI

struct ContentView: View {
    @State private var board = Array(repeating: "", count: 9)
    @State private var currentPlayer = "X"
    @State private var winner: String? = nil

    let winningCombos = [
        [0, 1, 2], [3, 4, 5], [6, 7, 8],
        [0, 3, 6], [1, 4, 7], [2, 5, 8],
        [0, 4, 8], [2, 4, 6]
    ]

    var body: some View {
        ZStack {
            MeshGradient(
                width: 2,
                height: 2,
                points: [
                    [0, 0], [1, 0],
                    [0, 1], [1, 1]
                ],
                colors: [
                    .black, .white,
                    .white, .black
                ]
            )
            .ignoresSafeArea()

            VStack(spacing: 20) {
                HStack(spacing: 0) {
                    Text("TIC-")
                        .font(.largeTitle)
                        .bold()
                        .foregroundStyle(.black)
                    Text("TAC")
                        .font(.largeTitle)
                        .bold()
                        .foregroundStyle(.white)
                    Text("-TOE")
                        .font(.largeTitle)
                        .bold()
                        .foregroundStyle(.black)
                }
                .padding()
                withAnimation {
                    Text("Turn: \(currentPlayer)")
                        .font(.largeTitle)
                        .bold()
                        .foregroundStyle(.white)
                        .padding(.top , 10)
                }
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 10) {
                    ForEach(0..<9) { i in
                        ZStack {
                            Rectangle()
                                .foregroundColor(.white.opacity(0.5))
                                .frame(height: 100)
                                .cornerRadius(10)
                            Text(board[i])
                                .font(.system(size: 50, weight: .bold))
                        }
                        .onTapGesture {
                            withAnimation {
                                if board[i] == "" && winner == nil {
                                    board[i] = currentPlayer
                                }
                            }
                            checkWinner()
                            if winner == nil {
                                currentPlayer = (currentPlayer == "X") ? "O" : "X"
                            }
                        }
                    }
                }
                Button("Restart") {
                    withAnimation {
                        board = Array(repeating: "", count: 9)
                        currentPlayer = "X"
                        winner = nil
                    }
                }
                .padding()
                .background(Color.black)
                .foregroundColor(.white)
                .cornerRadius(10)

                if let winner = winner {
                    Text(winner == "Draw" ? "It's a Draw!" : "\(winner) Wins!")
                        .font(.largeTitle)
                        .foregroundColor(.green)
                        .bold()
                        .padding(10)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.black.opacity(0.7))
                                .shadow(color: .white.opacity(0.5), radius: 5, x: 0, y: 0)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.green, lineWidth: 2)
                        )
                        .transition(.opacity.combined(with: .slide))
                }
            }
            .padding()
        }
        .animation(.easeInOut(duration: 0.5), value: winner) 
    }

    func checkWinner() {
        for combo in winningCombos {
            let a = combo[0], b = combo[1], c = combo[2]
            if board[a] != "" && board[a] == board[b] && board[b] == board[c] {
                winner = board[a]
                return
            }
        }

        if !board.contains("") {
            winner = "Draw"
        }
    }
}

#Preview {
    ContentView()
}
