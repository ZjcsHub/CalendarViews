//
//  CalendarPickerView.swift
//  OplayerSport
//
//  Created by App005 SYNERGY on 2019/7/24.
//  Copyright © 2019 App005 SYNERGY. All rights reserved.
//

import UIKit
import DateToolsSwift


@objc protocol CalendarPickerViewDelegate:Any {
    @objc optional func didSeleteDate(date:Date)
}


// 日历选择视图
class CalendarPickerView: UIView {

   private var selectedDate:Date? {
        didSet {
            
            if self.delegate?.didSeleteDate != nil , let date = self.selectedDate {
                self.delegate?.didSeleteDate!(date: date)
            }
            
        }
    }
    
    weak var delegate:CalendarPickerViewDelegate?
    
    private var startDate:Date?
    
    private let OFFSETDAYS:Int = 100 * 7
    
    private let sizeWidth = VIEW_WIDTH / 7
    
    private let sizeHeight:CGFloat = 69
    
    
    lazy var todayButton:UIButton = {
        
       let button = UIButton(type: .custom)
        button.setTitle(NSLocalizedString("main_tab_today", comment: "Today"), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .red
        button.layer.cornerRadius = sizeWidth/2
        button.layer.masksToBounds = true
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.isHidden = true
        button.addTarget(self, action: #selector(todaySelectDate), for: .touchUpInside)
        return button
    }()
    
    
    lazy var dateCollectView:CalendarCollectionView = {
        
        let flowLayout = OplayerCollectionLayOut(insets: .zero, miniLineSpace: 0, miniInterItemSpace: 0, itemSize: CGSize(width: sizeWidth, height: sizeHeight))
       
        let collectView = CalendarCollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectView.backgroundColor = UIColor.clear
        collectView.dataSource = self
        collectView.delegate = self
        collectView.showsHorizontalScrollIndicator = false
        collectView.register(UINib(nibName: "CalendarCell", bundle: nil), forCellWithReuseIdentifier: NSStringFromClass(CalendarCell.self))
        
        return collectView
    }()
    
    
    lazy var dateDataList:Array<Date> = {
        var array = Array<Date>()
        if let startDate = selectedDate {
            array.append(startDate)
            let weekNumber = startDate.weekday
            for i in 1 ... (OFFSETDAYS + weekNumber - 1) {
                array.insert(Date.nextDays(n: -i, date: startDate)! , at: 0)
            }
            for i in 1...3 {
                array.append(Date.nextDays(n: i, date: startDate)!)
            }
        }
        return array
    }()
    
    convenience init(startDate:Date) {
        self.init()
        self.selectedDate = startDate
        self.startDate = startDate
        addSubview(dateCollectView)
        
        dateCollectView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self)
            make.height.equalTo(sizeHeight)
        }
        
        addSubview(todayButton)
        todayButton.snp.makeConstraints { (make) in
            make.right.equalTo(self)
            make.width.height.equalTo(sizeWidth)
            make.centerY.equalTo(self.dateCollectView.snp.centerY)
        }
        
        perform(#selector(scrollToEnd), with: nil, afterDelay: 0.0)
        
    }

    @objc func scrollToEnd() {
        
        if let date = selectedDate  {
            let index = dateDataList.firstIndex(of: date) ?? dateDataList.count - 1
            let indexPath = IndexPath(item: index, section: 0)
            dateCollectView.scrollToItem(at: indexPath, at: UICollectionView.ScrollPosition.centeredHorizontally, animated: false)
            _ = DelayTask.delay(0.01) {
                self.dateCollectView.selectItem(at: indexPath, animated: true, scrollPosition: UICollectionView.ScrollPosition.centeredHorizontally)
            }
        }
        
       
    }
    
    @objc func todaySelectDate() {
        selectedDate = startDate
        scrollToEnd()
    }
}

extension CalendarPickerView:UICollectionViewDataSource,UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dateDataList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(CalendarCell.self), for: indexPath) as! CalendarCell
        let date = self.dateDataList[indexPath.item]
        cell.selectDate = date
        let result = date.isEarlyThan(date: Date())
        if (result == ComparisonResult.orderedDescending) {
           cell.isUserInteractionEnabled = false
        }else{
           cell.isUserInteractionEnabled = true
        }
        return cell
    }
    
   
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
        self.selectedDate = self.dateDataList[indexPath.item]
        if indexPath.item <= 2 {
            addLastBatchData()
        }
    }
    
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let contentOffsetX = scrollView.contentOffset.x
        if scrollView == dateCollectView ,contentOffsetX <= 0  {
            addLastBatchData()
        }
        
        if decelerate == false {
            scrollViewDidEndDecelerating(scrollView)
        }
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let index = Int((dateCollectView.contentOffset.x + dateCollectView.frame.size.width/2.0) / sizeWidth)
        self.selectedDate = self.dateDataList[index]
        dateCollectView.scrollToItem(at: IndexPath(item: index , section: 0), at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let index = Int((dateCollectView.contentOffset.x + dateCollectView.frame.size.width/2.0) / sizeWidth)

        if self.dateDataList.count - index > 6 {
            todayButton.isHidden = false

        }else{
            todayButton.isHidden = true
        }
        
    }
    
    // 添加数据
    func addLastBatchData()  {
        guard let tempDate = dateDataList.first else {
            return
        }
        
        for i in 1...OFFSETDAYS {
            dateDataList.insert(Date.nextDays(n: -i, date: tempDate)!, at: 0)
        }
        
        dateCollectView.reloadData()
        _ = DelayTask.delay(0.05) {
            self.scrollToEnd()
        }
       
    }
}
