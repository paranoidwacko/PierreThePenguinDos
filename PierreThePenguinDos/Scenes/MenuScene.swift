import Foundation
import SpriteKit
import GameKit

/**
 Scene to represent the menu options at the start of the game
 - author: Wacko
 - date: 10/13/2018
 */
class MenuScene: BaseScene, GKGameCenterControllerDelegate {
    private static let KEY_BUTTON_LEADERBOARD = "LeaderboardBtn"
    private static let KEY_BUTTON_START = "StartBtn"
    private static let TEXT_APP_TITLE = LocalString(key: "app_title")
    private static let TEXT_APP_SUBTITLE = LocalString(key: "app_subtitle")
    private static let TEXT_MENU_BUTTON_LEADERBOARD = LocalString(key: "menu_button_leaderboard")
    private static let TEXT_MENU_BUTTON_START = LocalString(key: "menu_button_start")
    
    private let backgroundImage: BaseSpriteNode
    private let logoText: BaseLabelNode
    private let logoTextBottom: BaseLabelNode
    private let startButton: BaseSpriteNode
    private let startText: BaseLabelNode
    
    override init(size: CGSize) {
        self.backgroundImage = BaseSpriteNode(imageNamed: TextureName.BackgroundMenu.rawValue, size: CGSize(width: 1024, height: 768), zPosition: -1)
        self.logoText = BaseLabelNode(fontNamed: FontName.AvenirNextHeavy.rawValue, text: MenuScene.TEXT_APP_TITLE, position: CGPoint(x: 0, y: 100), fontSize: 60)
        self.logoTextBottom = BaseLabelNode(fontNamed: FontName.AvenirNextHeavy.rawValue, text: MenuScene.TEXT_APP_SUBTITLE, position: CGPoint(x: 0, y: 50), fontSize: 40)
        self.startButton = BaseSpriteNode(name: MenuScene.KEY_BUTTON_START, position: CGPoint(x: 0, y: -20), size: CGSize(width: 295, height: 76), texture: TextureManager.Texture(textureName: TextureName.Button))
        self.startText = BaseLabelNode(fontNamed: FontName.AvenirNextHeavyItalic.rawValue, text: MenuScene.TEXT_MENU_BUTTON_START, position: CGPoint(x: 0, y: 2), fontSize: 40, name: MenuScene.KEY_BUTTON_START, verticalAlignmentMode: .center, zPosition: 5)
        super.init(size: size)
    }
    
    override func didMove(to view: SKView) {
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.startText.onTouch = { [weak self] in
            if let myself = self {
                myself.view?.presentScene(GameScene(size: myself.size))
            }
        }
        
        self.addChild(backgroundImage)
        self.addChild(logoText)
        self.addChild(logoTextBottom)
        self.addChild(self.startButton)
        self.startButton.addChild(startText)
        
        self.startText.run(SKAction.repeatForever(FadeAnimation()))
        if GKLocalPlayer.local.isAuthenticated {
            self.createLeaderboardButton()
        }
    }
    
    func createLeaderboardButton() {
        let leaderboardText = BaseLabelNode(fontNamed: FontName.AvenirNext.rawValue, text: MenuScene.TEXT_MENU_BUTTON_LEADERBOARD, position: CGPoint(x: 0, y: -100), fontSize: 20, name: MenuScene.KEY_BUTTON_LEADERBOARD)
        leaderboardText.onTouch = { [weak self] in
            self?.showLeaderboard()
        }
        self.addChild(leaderboardText)
    }
    
    func showLeaderboard() {
        let gameCenter = GKGameCenterViewController()
        gameCenter.gameCenterDelegate = self
        gameCenter.viewState = GKGameCenterViewControllerState.leaderboards
        if let gameViewController = self.view?.window?.rootViewController {
            gameViewController.show(gameCenter, sender: self)
            gameViewController.navigationController?.pushViewController(gameCenter, animated: true)
        }
    }
    
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
