//
//  ViewController.swift
//  PickerExmpler
//
//  Created by Shaun Hubbard on 12/4/18.
//

import UIKit

typealias PickerType = (heading: String, subheading: String)

class ViewController: UIViewController {
  let pickerItems: [PickerType] = [
    ("Neque", "Lorem ipsum dolor sit amet, consectetur adipiscing elit."),
    ("Ipsum", "Nam orci orci, porttitor at ligula eget, rhoncus suscipit ante."),
    ("Dolor", "Maecenas et mauris a risus ornare aliquet nec sit amet ligula."),
    ("Sit", "Phasellus bibendum mauris sed laoreet vestibulum. "),
    ("Amet", "Phasellus libero elit, tincidunt nec viverra ac, egestas id est.")]


  @IBOutlet weak var textField: UITextField!

  override func viewDidLoad() {
    super.viewDidLoad()

    let picker = UIPickerView()
    picker.delegate = self
    picker.dataSource = self

    textField.inputView = picker

    let toolbar = UIToolbar()
    toolbar.items = [UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil), UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))]
    toolbar.sizeToFit()
    textField.inputAccessoryView = toolbar
  }

  @objc
  func done(_ sender: UIResponder) {
    sender.resignFirstResponder()
  }
}

extension ViewController: UIPickerViewDelegate {

}

extension ViewController: UIPickerViewDataSource {
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }

  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return pickerItems.count
  }


  func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
    let view = ExampleView()
    view.configure(pickerItems[row])
    return view
  }

  func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
    return 50
  }
}



class ExampleView: UIView {
  private let titleLabel = UILabel()
  private let subTitleLabel = UILabel()
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .white
    titleLabel.text = "Stuff"
    titleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
    subTitleLabel.text = "And Lots of things"
    subTitleLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)

    let stackView = UIStackView(arrangedSubviews: [titleLabel, subTitleLabel])
    stackView.axis = .vertical
    stackView.spacing = 3
    stackView.alignment = .fill
    stackView.distribution = .fillProportionally
    stackView.translatesAutoresizingMaskIntoConstraints = false
    addSubview(stackView)

    let viewsDictionary = ["stackView":stackView]
    let margin = 2
    let stackViewHeightConstraint = NSLayoutConstraint.constraints(
      withVisualFormat: "H:|-\(margin)-[stackView]-\(margin)-|",  //horizontal constraint 20 points from left and right side
      options: [],
      metrics: nil,
      views: viewsDictionary)
    let stackView_V = NSLayoutConstraint.constraints(
      withVisualFormat: "V:|-\(margin)-[stackView]-\(margin)-|", //vertical constraint 30 points from top and bottom
      options: [],
      metrics: nil,
      views: viewsDictionary)
    addConstraints(stackViewHeightConstraint)
    addConstraints(stackView_V)

  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("insert table flip emoji here")
  }

  func configure(_ pickerType: PickerType) {
    titleLabel.text = pickerType.heading
    subTitleLabel.text = pickerType.subheading
  }
}
