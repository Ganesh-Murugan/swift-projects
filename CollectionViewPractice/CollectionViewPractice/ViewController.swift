//
//  ViewController.swift
//  CollectionViewPractice
//
//  Created by zoho on 21/06/22.
//

import UIKit

class ViewController: UIViewController {
    private var calculator = CalculatorCells()
    private var values: [Calculator] { calculator.values }
    private var prevValue = ""
    { didSet { prevValue = prevValue.filterValues(value: "-0123456789.") } }
    var rightValue = ""
    var nextValue = Double()
    var resultValue = Double()
    var prevOperator: Operators = .unspecified{
        didSet {  }
    }
    
    
    private var cellViewlayout: UICollectionViewFlowLayout = {
        var layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 0.2
        layout.headerReferenceSize = CGSize(width: 420, height: 300)
        return layout
    }()
    //    private var resultView: UILabel = {
    //        var resultView = UILabel(frame: CGRect(x: 10, y: 200, width: 380, height: 100))
    //        resultView.backgroundColor = .opaqueSeparator
    //        resultView.textColor = .black
    //        resultView.textAlignment = .right
    //        return resultView
    //    }()
    private var textFeild: UITextView = {
        var textView = UITextView()
        textView.textInputView.frame = textView.bounds
        textView.backgroundColor = .black
        textView.textAlignment = .right
        textView.frame = CGRect(x: 10, y: 140, width: 400, height: 60)
        textView.textColor = .white
        textView.font = UIFont.systemFont(ofSize: 30)
        //        textView.textContainer.size = CGSize(width: 420, height: 100)
        textView.textContainer.maximumNumberOfLines = 1
        textView.layer.borderWidth = 0.2
        textView.layer.borderColor = UIColor.black.cgColor
        textView.isUserInteractionEnabled = false
        return textView
    }()
    
    private var calculatorView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    private func setupCalculatorView() {
        view.addSubview(calculatorView)
        calculatorView.addSubview(textFeild)
        //        textFeild.addSubview(resultView)
        calculatorView.dataSource = self
        calculatorView.delegate = self
        calculatorView.backgroundColor = .black
        calculatorView.collectionViewLayout = cellViewlayout
        calculatorView.register(CalculatorCollectionViewCell.self, forCellWithReuseIdentifier: Identifiers.calculatorCollectionViewCellIdentifier)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCalculatorView()
    }
    
    override func viewDidLayoutSubviews() {
        calculatorView.frame = view.bounds
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        indexPath.item == 16 ? CGSize(width: 214, height: 80) : CGSize(width: 107, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return values.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: Identifiers.calculatorCollectionViewCellIdentifier,
            for: indexPath
        ) as! CalculatorCollectionViewCell
        cell.applyColor(indexPath.item)
        cell.addLabel(values, indexPath.item)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) {
            cell.layer.borderWidth = 2
            cell.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
    }

    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) {
            cell.layer.borderWidth = 0
        }
    }
    
    func calculation(_ prevOperation: Operators) {
        print("called", prevOperation)
        switch prevOperation {
        case .addition:
            resultValue = prevValue.toDouble + rightValue.toDouble
        case .subtraction:
            resultValue =  prevValue.toDouble - rightValue.toDouble
        case .multiplication:
            resultValue = prevValue.toDouble * rightValue.toDouble
        case .division:
            print(rightValue.toDouble ,"/", prevValue.toDouble)
            resultValue = prevValue.toDouble / rightValue.toDouble
        case .mod:
            resultValue = prevValue.toDouble.truncatingRemainder(dividingBy: rightValue.toDouble)
        
        default :
            print("_")
        }
        textFeild.text = resultValue.formatDecimal
        prevValue = resultValue.formatDecimal
        rightValue = ""
        prevOperator = prevOperation
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let type = values[indexPath.item].type
        let cell = calculatorView.cellForItem(at: indexPath) as! CalculatorCollectionViewCell
        let value = type != .numeric
        cell.highlightColor(value)
        textFeild.text += values[indexPath.item].value.filterValues(value: "0123456789.")
        switch type {
        case .numeric, .Operations(.dot):
            if prevOperator == .unspecified {
                prevValue += values[indexPath.item].value
            } else {
                rightValue += values[indexPath.item].value
                textFeild.text = rightValue
            }
            
        case .Operations(.clear):
            (textFeild.text, prevOperator, prevValue, rightValue, resultValue) = ("",.unspecified,"","",0)
            
        case .Operations(.equal):
            calculation(prevOperator)
//            prevOperator = .unspecified
        case .Operations(.negate):
            prevValue = "-" + prevValue
            textFeild.text.removeLast()
            textFeild.text = prevValue
            print(prevValue)
        case .Operations(let operation):
//            textFeild.text.removeAll()
            if resultValue != 0 {
                calculation(operation)
            }
            if prevOperator != .unspecified {
                calculation(prevOperator)
            }
            prevOperator = operation
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = calculatorView.cellForItem(at: indexPath) as! CalculatorCollectionViewCell
        cell.highlightColor(false)
    }
}
