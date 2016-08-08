import iOS_tic_tac_toe
import Quick
import Nimble

class BoardStackViewTests: QuickSpec {
    override func spec() {
        var boardView: BoardStackView!
        
        beforeEach() {
            boardView = BoardStackView()
        }
        describe("BoardStackView") {
            
            it ("can disable all buttons on the board") {
                boardView.disableSpots()
                expect(self.buttonsEnabled(boardView, enabled: false)).to(beTrue())
            }
            
            it("can enable all of the spots") {
                boardView.disableSpots()
                boardView.enableSpots()
                expect(self.buttonsEnabled(boardView, enabled: true)).to(beTrue())
            }
            
            it("can enable only the empty spots") {
                boardView.disableSpots()
                boardView.show(board: ["X","X","","","","O","","",""])
                boardView.enableSpots()
                expect(self.buttonsEnabled(boardView, enabled: false)).to(beTrue())
            }
            
            it("can prevent a player from playing again on the same spot") {
                expect(self.buttonsEnabled(boardView, enabled: true)).to(beTrue())
                
                boardView.show(board:["X","X","O","X","O","X","O","X","X"])
                
                expect(self.buttonsEnabled(boardView, enabled: false)).to(beTrue())
            }
            
            it("can resize the image to the size of a button") {
                let button = UIButton()
                let oMarker = UIImage(named: "letter-o")!
                button.frame = CGRectMake(0, 0, 100, 100)
                let resizedImage = boardView.scaleImage(oMarker, button: button)

                expect(oMarker.size.height).toNot(equal(100))
                expect(oMarker.size.width).toNot(equal(100))
                expect(resizedImage.size.height).to(equal(100))
                expect(resizedImage.size.width).to(equal(100))
            }
            
            it("can get an image for a marker") {
                let xMarker = UIImage(named: "letter-x")!
                expect(boardView.getImageForMarker("X")).to(equal(xMarker))
            }
            
            
            it("can clear the board") {
                boardView.clearSpots()
                for view in boardView.subviews{
                    for button in view.subviews {
                        let btn = button as! UIButton
                        expect(btn.titleLabel).to(equal(""))
                    }
                }
            }
        }
    }
    
    func buttonsEnabled(boardView: UIStackView, enabled: Bool) -> Bool {
        for view in boardView.subviews{
            for button in view.subviews {
                let btn = button as! UIButton
                if (btn.enabled != enabled) {
                    return false
                }
            }
        }
        return true
    }
}