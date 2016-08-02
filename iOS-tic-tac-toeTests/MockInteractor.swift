import iOS_tic_tac_toe
import Foundation

public class MockInteractor: NSObject, GameInteractor {
    public var game: Game!
    public var moveMade: Int!
    public var turnCompleted: Bool! = false
    
    public required init(boardView: BoardView, statusView: StatusView) {
        
    }
    
    public func startGame(game: Game) {
        
    }
    
    public func makeMove(spotIndex: Int) {
        moveMade = spotIndex
    }
    
    public func completeTurn() {
        turnCompleted = true
    }
    

}