//
//  TapCounterView.swift
//  GameWatch
//
//  Created by Auto on 07/01/2026.
//

import SwiftUI

struct TapCounterView: View {
    @Environment(\.dismiss) private var dismiss
    @Bindable var game: GameViewModel
    var step: GameStep
    
    @State private var grid: [[Character]] = []
    @State private var wordsToFind: [String] = []
    @State private var foundWords: Set<String> = []
    @State private var foundWordPositions: [String: Set<GridPosition>] = [:]
    @State private var selectedCells: Set<GridPosition> = []
    @State private var currentWord: String = ""
    @State private var timeRemaining: TimeInterval = 60
    @State private var isCompleted: Bool = false
    @State private var didDismiss = false
    @State private var timer: Timer?
    @State private var lastSelectedPosition: GridPosition?
    @State private var showSuccessAnimation: Bool = false
    @State private var successWord: String = ""
    @State private var isDragging: Bool = false
    @State private var dragStartPosition: GridPosition?
    @State private var showFailureMessage: Bool = false
    
    struct GridPosition: Hashable {
        let row: Int
        let col: Int
    }
    
    // Déterminer la difficulté à partir de la durée du jeu
    private var difficulty: GameDifficulty {
        let totalDuration = game.game.duration
        if totalDuration >= 300 { // 5 minutes
            return .easy
        } else if totalDuration >= 180 { // 3 minutes
            return .medium
        } else {
            return .hard
        }
    }
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                // Fond avec gradient
                LinearGradient(
                    colors: [
                        Color(red: 0.1, green: 0.1, blue: 0.2),
                        Color(red: 0.05, green: 0.05, blue: 0.15),
                        Color.black
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // Header
                    VStack(spacing: 12) {
                        Text("Mots Croisés")
                            .font(.system(size: 28, weight: .bold, design: .rounded))
                            .foregroundStyle(
                                LinearGradient(
                                    colors: [.cyan, .blue, .purple],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                        
                        HStack(spacing: 20) {
                            VStack(spacing: 4) {
                                Text("Temps")
                                    .font(.caption)
                                    .foregroundStyle(.gray)
                                Text(formatTime(timeRemaining))
                                    .font(.title2.bold())
                                    .foregroundStyle(timeRemaining < 15 ? .red : .cyan)
                            }
                            
                            Divider()
                                .frame(height: 40)
                                .background(Color.white.opacity(0.2))
                            
                            VStack(spacing: 4) {
                                Text("Trouvés")
                                    .font(.caption)
                                    .foregroundStyle(.gray)
                                Text("\(foundWords.count)/\(wordsToFind.count)")
                                    .font(.title2.bold())
                                    .foregroundStyle(.white)
                            }
                        }
                        .padding(.horizontal)
                    }
                    .padding(.top, 20)
                    .padding(.bottom, 16)
                    
                    // Liste des mots à trouver
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            ForEach(wordsToFind, id: \.self) { word in
                                WordChip(
                                    word: word,
                                    isFound: foundWords.contains(word.uppercased())
                                )
                            }
                        }
                        .padding(.horizontal)
                    }
                    .frame(height: 50)
                    .padding(.bottom, 12)
                    
                    // Grille de lettres
                    GeometryReader { gridGeo in
                        VStack(spacing: 2) {
                            ForEach(0..<grid.count, id: \.self) { row in
                                HStack(spacing: 2) {
                                    ForEach(0..<grid[row].count, id: \.self) { col in
                                        let position = GridPosition(row: row, col: col)
                                        let isSelected = selectedCells.contains(position)
                                        
                                        LetterCell(
                                            letter: String(grid[row][col]),
                                            isSelected: isSelected,
                                            isFound: isLetterInFoundWord(position: position)
                                        )
                                    }
                                }
                            }
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color.black.opacity(0.3))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(
                                            LinearGradient(
                                                colors: [.cyan.opacity(0.5), .purple.opacity(0.5)],
                                                startPoint: .topLeading,
                                                endPoint: .bottomTrailing
                                            ),
                                            lineWidth: 2
                                        )
                                )
                        )
                        .gesture(
                            DragGesture(minimumDistance: 0)
                                .onChanged { value in
                                    guard !isCompleted && timeRemaining > 0 else { return }
                                    
                                    if !isDragging {
                                        isDragging = true
                                        let startPos = positionFromLocation(
                                            location: value.startLocation,
                                            in: gridGeo.size
                                        )
                                        dragStartPosition = startPos
                                        selectedCells = [startPos]
                                        lastSelectedPosition = startPos
                                    }
                                    
                                    let currentPos = positionFromLocation(
                                        location: value.location,
                                        in: gridGeo.size
                                    )
                                    
                                    if let startPos = dragStartPosition {
                                        selectCellsBetween(from: startPos, to: currentPos)
                                        updateCurrentWord()
                                    }
                                }
                                .onEnded { _ in
                                    isDragging = false
                                    updateCurrentWord()
                                    checkWord()
                                    dragStartPosition = nil
                                }
                        )
                        .simultaneousGesture(
                            TapGesture()
                                .onEnded { _ in
                                    if !isDragging {
                                        selectedCells = []
                                        lastSelectedPosition = nil
                                        currentWord = ""
                                    }
                                }
                        )
                    }
                    .padding(.horizontal)
                    .frame(maxHeight: geo.size.height * 0.5)
                    
                    Spacer()
                    
                    // Zone de feedback
                    VStack(spacing: 12) {
                        if !currentWord.isEmpty {
                            Text("Mot sélectionné: \(currentWord)")
                                .font(.headline)
                                .foregroundStyle(.cyan)
                                .padding(.horizontal)
                        }
                        
                        if showSuccessAnimation {
                            Text("✨ \(successWord) trouvé ! ✨")
                                .font(.title2.bold())
                                .foregroundStyle(.yellow)
                                .scaleEffect(showSuccessAnimation ? 1.2 : 1.0)
                                .animation(.spring(response: 0.3, dampingFraction: 0.6), value: showSuccessAnimation)
                        }
                        
                        if showFailureMessage {
                            Text("⏱️ Temps écoulé !")
                                .font(.title2.bold())
                                .foregroundStyle(.red)
                                .scaleEffect(showFailureMessage ? 1.2 : 1.0)
                                .animation(.spring(response: 0.3, dampingFraction: 0.6), value: showFailureMessage)
                        }
                        
                        // Barre de progression
                        GeometryReader { progressGeo in
                            ZStack(alignment: .leading) {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.gray.opacity(0.2))
                                    .frame(height: 12)
                                
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(
                                        LinearGradient(
                                            colors: [.cyan, .blue, .purple],
                                            startPoint: .leading,
                                            endPoint: .trailing
                                        )
                                    )
                                    .frame(
                                        width: progressGeo.size.width * CGFloat(foundWords.count) / CGFloat(wordsToFind.count),
                                        height: 12
                                    )
                                    .animation(.spring(response: 0.5, dampingFraction: 0.8), value: foundWords.count)
                            }
                        }
                        .frame(height: 12)
                        .padding(.horizontal, 40)
                    }
                    .padding(.bottom, 30)
                }
            }
        }
        .onAppear {
            setupGame()
        }
        .onDisappear {
            stopTimer()
        }
        .onChange(of: isCompleted) { _, completed in
            if completed, !didDismiss {
                didDismiss = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    game.completeStep(step: step.id)
                    dismiss()
                }
            }
        }
        .onChange(of: timeRemaining) { _, newTime in
            if newTime <= 0 && !isCompleted && !didDismiss {
                stopTimer()
                showFailureMessage = true
                // Temps écoulé - appliquer une pénalité et fermer
                game.applyPenality()
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    didDismiss = true
                    dismiss()
                }
            }
        }
    }
    
    private func setupGame() {
        // Sélectionner les mots selon la difficulté
        let allWords = WordSearchRepository.availableWords
        switch difficulty {
        case .easy:
            wordsToFind = Array(allWords.shuffled().prefix(4))
            timeRemaining = 90
        case .medium:
            wordsToFind = Array(allWords.shuffled().prefix(5))
            timeRemaining = 75
        case .hard:
            wordsToFind = Array(allWords.shuffled().prefix(6))
            timeRemaining = 60
        }
        
        // Générer la grille
        grid = WordSearchRepository.generateGrid(words: wordsToFind, size: 10)
        
        startTimer()
    }
    
    private func positionFromLocation(location: CGPoint, in size: CGSize) -> GridPosition {
        guard !grid.isEmpty && !grid[0].isEmpty else {
            return GridPosition(row: 0, col: 0)
        }
        
        let padding: CGFloat = 16
        let spacing: CGFloat = 2
        let availableWidth = size.width - (padding * 2)
        let availableHeight = size.height - (padding * 2)
        
        let cellWidth = (availableWidth - (spacing * CGFloat(grid[0].count - 1))) / CGFloat(grid[0].count)
        let cellHeight = (availableHeight - (spacing * CGFloat(grid.count - 1))) / CGFloat(grid.count)
        
        let adjustedX = location.x - padding
        let adjustedY = location.y - padding
        
        var col = 0
        var currentX: CGFloat = 0
        for i in 0..<grid[0].count {
            if adjustedX >= currentX && adjustedX < currentX + cellWidth {
                col = i
                break
            }
            currentX += cellWidth + spacing
        }
        
        var row = 0
        var currentY: CGFloat = 0
        for i in 0..<grid.count {
            if adjustedY >= currentY && adjustedY < currentY + cellHeight {
                row = i
                break
            }
            currentY += cellHeight + spacing
        }
        
        col = max(0, min(grid[0].count - 1, col))
        row = max(0, min(grid.count - 1, row))
        
        return GridPosition(row: row, col: col)
    }
    
    private func selectCellsBetween(from: GridPosition, to: GridPosition) {
        guard !isCompleted && timeRemaining > 0 else { return }
        
        var newSelection = Set<GridPosition>()
        
        let rowDiff = to.row - from.row
        let colDiff = to.col - from.col
        
        if rowDiff == 0 {
            // Horizontal
            let minCol = min(from.col, to.col)
            let maxCol = max(from.col, to.col)
            for col in minCol...maxCol {
                newSelection.insert(GridPosition(row: from.row, col: col))
            }
        } else if colDiff == 0 {
            // Vertical
            let minRow = min(from.row, to.row)
            let maxRow = max(from.row, to.row)
            for row in minRow...maxRow {
                newSelection.insert(GridPosition(row: row, col: from.col))
            }
        } else if abs(rowDiff) == abs(colDiff) {
            // Diagonal
            let rowStep = rowDiff > 0 ? 1 : -1
            let colStep = colDiff > 0 ? 1 : -1
            var currentRow = from.row
            var currentCol = from.col
            
            newSelection.insert(from)
            while currentRow != to.row || currentCol != to.col {
                currentRow += rowStep
                currentCol += colStep
                newSelection.insert(GridPosition(row: currentRow, col: currentCol))
            }
        } else {
            newSelection.insert(from)
        }
        
        selectedCells = newSelection
        if let last = newSelection.sorted(by: { $0.row < $1.row || ($0.row == $1.row && $0.col < $1.col) }).last {
            lastSelectedPosition = last
        }
    }
    
    private func updateCurrentWord() {
        let sortedCells = selectedCells.sorted { pos1, pos2 in
            if pos1.row == pos2.row {
                return pos1.col < pos2.col
            }
            return pos1.row < pos2.row
        }
        
        currentWord = sortedCells.map { pos in
            String(grid[pos.row][pos.col])
        }.joined()
    }
    
    private func checkWord() {
        let upperWord = currentWord.uppercased()
        
        if wordsToFind.contains(where: { $0.uppercased() == upperWord }) && !foundWords.contains(upperWord) {
            foundWords.insert(upperWord)
            foundWordPositions[upperWord] = selectedCells
            successWord = upperWord
            showSuccessAnimation = true
            
            selectedCells = []
            currentWord = ""
            lastSelectedPosition = nil
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                showSuccessAnimation = false
            }
            
            if foundWords.count >= wordsToFind.count {
                isCompleted = true
                stopTimer()
            }
        }
    }
    
    private func isLetterInFoundWord(position: GridPosition) -> Bool {
        for (_, positions) in foundWordPositions {
            if positions.contains(position) {
                return true
            }
        }
        return false
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                stopTimer()
            }
        }
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    private func formatTime(_ time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

// Vue pour une cellule de lettre
struct LetterCell: View {
    let letter: String
    let isSelected: Bool
    let isFound: Bool
    
    var body: some View {
        Text(letter)
            .font(.system(size: 18, weight: .bold, design: .rounded))
            .foregroundStyle(isFound ? .green : (isSelected ? .white : .cyan))
            .frame(width: 32, height: 32)
            .background(
                RoundedRectangle(cornerRadius: 6)
                    .fill(
                        isFound ? Color.green.opacity(0.3) :
                        isSelected ? Color.cyan.opacity(0.5) :
                        Color.white.opacity(0.1)
                    )
            )
            .overlay(
                RoundedRectangle(cornerRadius: 6)
                    .stroke(
                        isFound ? Color.green :
                        isSelected ? Color.cyan :
                        Color.white.opacity(0.2),
                        lineWidth: isSelected ? 2 : 1
                    )
            )
            .scaleEffect(isSelected ? 1.1 : 1.0)
            .animation(.spring(response: 0.2, dampingFraction: 0.7), value: isSelected)
    }
}

// Vue pour un chip de mot
struct WordChip: View {
    let word: String
    let isFound: Bool
    
    var body: some View {
        Text(word)
            .font(.system(size: 14, weight: .semibold, design: .rounded))
            .foregroundStyle(isFound ? .green : .white)
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(isFound ? Color.green.opacity(0.3) : Color.white.opacity(0.1))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(isFound ? Color.green : Color.white.opacity(0.3), lineWidth: 1.5)
            )
            .strikethrough(isFound)
            .opacity(isFound ? 0.6 : 1.0)
    }
}

#Preview {
    let game = GameFactory.gameFrom(
        difficulty: .medium,
        options: GameOptions(soundEnabled: true, hapticsEnabled: true, gameExplanationsEnabled: true),
        name: "Test"
    )
    
    let vm = GameViewModel(game: game)
    
    let step = game.steps.first(where: { $0.miniGame.type == .tapCounter }) ?? game.steps.first!
    
    TapCounterView(game: vm, step: step)
        .background(Color.black)
}
