//
//  ViewController.swift
//  MountainXML
//
//  Created by 503 on 2020/03/16.
//  Copyright © 2020 ssang. All rights reserved.
//

import UIKit
class Mountain:Decodable{
    var list:Array<String> = Array<String>()
}
class ViewController: UIViewController {

    @IBOutlet weak var t_input: UITextField!
    @IBOutlet weak var area: UITextView!
    
    @IBAction func btnClick(_ sender: Any) {
        loadData()
    }
    //Node.js 에게 JSON 데이터 요청하기
    //파라미터 전송해야함 (GET)
    func loadData(){
        
        //비동기객채
        var urlSession = URLSession.shared
        
        var urlComponent = URLComponents(string:"http://localhost:7777/mnt")!
        
        //헤더에 파라미터 탑재하기 key - value
        //URLQuery?item 파라미터 한쌍을 탑재
        var params = [URLQueryItem]()
        
        params.append(URLQueryItem(name: "name", value: t_input.text!))
        
        urlComponent.queryItems = params
        
        //GET방식을 지정 : URLRequest
        var urlRequest = URLRequest(url:urlComponent.url!)
        urlRequest.httpMethod = "GET"
        
        urlSession.dataTask(with: urlRequest, completionHandler: {(data,response,error) in
            //서버에서 전송된 산의 행정주소를 넘겨받아
            //화면에 출력할 얘정
            //main 실행부에 반영을 요청하자 !!
            let str = String(data: data!, encoding: String.Encoding.utf8)
            print(data)
            
            //제이슨 파싱
            let decoder = JSONDecoder()
            do{
               var mountain = try decoder.decode(Mountain.self, from:data!)
                print("지역명은:",mountain.list[0])
                
                //UI제어문은 메안실행부에 부탁해야한다
                var buff=""
                
                DispatchQueue.main.async{
                    for i in 0..<mountain.list.count{
                        var local = mountain.list[i]
                        buff += local+"\n"
                    }
                    self.area.text = buff
                }
                
            }catch{
                
            }
            }).resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    

}

