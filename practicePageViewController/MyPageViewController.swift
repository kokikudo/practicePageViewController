// PageViewの作りかた
/*
 ストーリーボード：
 UIPageViewControllerを配置しファイル作成。
 表示させたいビューの数分のViewControllerを配置しファイル作成。
 Viewの名前をそのままIDに使いたいのでUse Storyboard IDにチェック
 
 ファイル：
 1. PageViewで表示させたいViewが入っているリストを定義
 2. PageViewControllerの初期化をする関数を作成
 3. 各Viewをインスタンス化
 4. インスタンス化したViewをリストに格納
 5. このコントローラーのdataSourceプロパティにこのコントローラー自身をセットする
 6. エクステンションでUIPageViewControllerDataSourceのデリゲートメソッドを定義する
 7. ページ数を指定する
 8. 左にスワイプした時の処理。今表示しているビューのインデックスを取得しそれが一番後ろでなければ次のビューを返す。
 9. 右にスワイプした時の処理。8と逆の処理。
 */

import UIKit

class MyPageViewController: UIPageViewController{
    
    // 1
    private var controllers: [UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initPageViewController()
    }
    
    // 2.
    private func initPageViewController() {
        
        // 3
        let firstView = storyboard!.instantiateViewController(identifier: "FirstView") as! ViewController
        let secondView = storyboard!.instantiateViewController(identifier: "SecondVIew") as! SecondViewController
        let thirdView = storyboard!.instantiateViewController(identifier: "ThirdView") as! ThirdViewController
        
        // 4
        self.controllers = [ firstView, secondView, thirdView ]
        
        // 10
        setViewControllers([self.controllers[0]], direction: .forward, animated: true, completion: nil)
        
        // 5
        self.dataSource = self
    }
    
}
// 6
extension MyPageViewController: UIPageViewControllerDataSource {
    
    // 7
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        self.controllers.count
    }
    
    // 8
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let nowViewIndex = self.controllers.firstIndex(of: viewController),
           nowViewIndex < self.controllers.count - 1 {
            return self.controllers[nowViewIndex + 1]
        } else {
            return nil
        }
    }
    
    // 9
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let nowViewIndex = self.controllers.firstIndex(of: viewController),
           nowViewIndex > 0 {
            return self.controllers[nowViewIndex - 1]
        } else {
            return nil
        }
    }
    
    
    
    
}
