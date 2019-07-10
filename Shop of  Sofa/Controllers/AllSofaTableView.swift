//
//  AllSofaTableView.swift
//  Shop of  Sofa
//
//  Created by Сергей Косилов on 09/07/2019.
//  Copyright © 2019 Сергей Косилов. All rights reserved.
//





import UIKit


class AllSofaTableView: UITableViewController {

   var arraySofaForTable = [ExplandableNames]()
    
    var allSofa: [Sofa]!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        allSofa = Sofa.all
        arraySofaForTable = allSofa.separationOnGroup()
        print(allSofa.count)
        print(arraySofaForTable.count)
    }

 

    override func numberOfSections(in tableView: UITableView) -> Int {


        return arraySofaForTable.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if !arraySofaForTable[section].isExplanded {
            return 0
        }
        
        return arraySofaForTable[section].name.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellOfAllSofa", for: indexPath) as! CellOfAllSofa
        let sofa = arraySofaForTable[indexPath.section].name[indexPath.row]
        cell.nameOfSofa.text = sofa.name
        cell.imageOfSofa.image = UIImage(named: sofa.image.first!)
        cell.nameOfCollection.text = sofa.category.rawValue
        return cell
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
       let button = UIButton(type: .system)
        button.setTitle("Закрыть", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = .blue
        button.addTarget(self, action: #selector(handleExplandClose), for: .touchUpInside)
        button.tag = section
        
        return button
    }
    
    @objc func handleExplandClose(button: UIButton){
        
        let section = button.tag
        var indexPaths = [IndexPath]()
        for row in arraySofaForTable[section].name.indices{
            let indexPath = IndexPath(row: row, section: section)
            indexPaths.append(indexPath)
        }
        
        let isExplanded = arraySofaForTable[section].isExplanded
        
        arraySofaForTable[section].isExplanded = !isExplanded
        button.setTitle(isExplanded ? "Open": "Close", for: .normal)
        if isExplanded {
           tableView.deleteRows(at: indexPaths, with: .fade)
        }else{
            tableView.insertRows(at: indexPaths, with: .fade)
           
        }
        
 
     
        
        
        
        
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 34
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }


}


//
//extension Array where Element == Sofa{
//
//    func separationOnGroup() -> [[Sofa]]{
//
//
//        var allSofa = [[Sofa]]()
//        var cornerFabric = [Sofa]()
//        var cornerLeather = [Sofa]()
//        var cornerModular = [Sofa]()
//        var straightFabric = [Sofa]()
//        var straightLeather = [Sofa]()
//
//
//        for sofa in self{
//        if sofa.category == Category.cornerFabric {
//            cornerFabric.append(sofa)} else{
//            if sofa.category == Category.cornerLeather{
//                cornerLeather.append(sofa)
//            }else{
//        if sofa.category == Category.cornerModular{
//            cornerModular.append(sofa)}else{
//            if sofa.category == Category.straightFabric{
//                straightFabric.append(sofa)} else{
//                if sofa.category == Category.straightLeather{
//            straightLeather.append(sofa)
//                }}}}}}
//        allSofa.append(cornerModular)
//        allSofa.append(cornerLeather)
//        allSofa.append(cornerFabric)
//        allSofa.append(straightFabric)
//        allSofa.append(straightLeather)
//
//
//        return allSofa
//
//}
//
//}
extension Array where Element == Sofa{
    
    func separationOnGroup() -> [ExplandableNames]{
        
        
        var allSofa = [ExplandableNames]()
        var cornerFabric = ExplandableNames(isExplanded: true, name: [])
        var cornerLeather = ExplandableNames(isExplanded: true, name: [])
        var cornerModular = ExplandableNames(isExplanded: true, name: [])
        var straightFabric = ExplandableNames(isExplanded: true, name: [])
        var straightLeather = ExplandableNames(isExplanded: true, name: [])
        
        for sofa in self{
        switch sofa.category {
        case .cornerFabric:
            cornerFabric.name.append(sofa)
            cornerFabric.isExplanded = true
            break
        case .straightLeather:
            straightLeather.name.append(sofa)
            straightLeather.isExplanded = true
            break
        case .straightFabric:
            straightFabric.name.append(sofa)
            straightFabric.isExplanded = true
            break
        case .cornerModular:
            cornerModular.name.append(sofa)
            cornerModular.isExplanded = true
            break
        case .cornerLeather:
            cornerLeather.name.append(sofa)
            cornerLeather.isExplanded = true
            break
            }
        }
            
            
     
        allSofa.append(cornerModular )
        allSofa.append(cornerLeather )
        allSofa.append(cornerFabric)
        allSofa.append(straightFabric)
        allSofa.append(straightLeather)
        
        
        return allSofa
        
    }
    
}
