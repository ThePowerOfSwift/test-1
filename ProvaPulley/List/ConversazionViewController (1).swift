import UIKit

class ConversazionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextViewDelegate{
    
    
    var tastieraSu = false
    
    var messaggi: [(String,Bool)] = [("ciao", true),("sono io", false),("ciao", true),("sono io", false),("ciao", true),("sono io", false),("ciao", true),("sono io", false)]
    
    
    @IBOutlet weak var tableview: UITableView!
    
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(ConversazionViewController.tastieraFuori(notifica:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ConversazionViewController.tastieraDentro(notifica:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @IBOutlet weak var constraintAltezzaText: NSLayoutConstraint!
    //        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.delegate = self
    tableview.rowHeight = UITableViewAutomaticDimension
        tableview.estimatedRowHeight = 90   // Do any additional setup after loading the view.
        hideKeyboardWhenTappedAround()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if messaggi.count != 0 {
            let indice = IndexPath.init(row: messaggi.count - 1, section: 0)
            tableview.scrollToRow(at: indice, at: .top, animated: true)
        }
    }
    @IBOutlet weak var textView: UITextView!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func send(_ sender: UIButton) {
        if textView.text != "" {
            messaggi.append((textView.text, true))
            let indice = IndexPath.init(row: messaggi.count - 1, section: 0)
            tableview.insertRows(at: [indice], with: .automatic)
            self.tableview.scrollToRow(at: indice, at: .top, animated: false)
            textView.text = ""
            textViewDidChange(textView)        }
        if textView.isFirstResponder {
            textView.resignFirstResponder()
        }
    }
    
    // gestione textview per scrivere
    func textViewDidChange(_ textView: UITextView) {
        textView.isScrollEnabled = false
        let larghezzaFissa = textView.frame.size.width
        let nuovaDimensione = textView.sizeThatFits(CGSize(width: larghezzaFissa, height: CGFloat.greatestFiniteMagnitude))
        let nuovaAltezza = nuovaDimensione.height
        if nuovaAltezza > 245.5 {
            textView.isScrollEnabled = true
        } else {
            var nuovoFrame = textView.frame
            nuovoFrame.size = CGSize(width: max (larghezzaFissa, nuovaDimensione.width), height: nuovaAltezza)
        constraintAltezzaText.constant = nuovaAltezza
            textView.frame = nuovoFrame
            
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messaggi.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let messaggio = messaggi[indexPath.row]
        if messaggio.1 {
            let cell = tableview.dequeueReusableCell(withIdentifier: "cellinviato", for: indexPath) as! ConversazionCell
            cell.lblData.text = "\(NSDate())"
            cell.lblMessaggio.text = messaggio.0
            cell.vricevi.layer.cornerRadius = 30.0
            cell.clipsToBounds = true
            
            print("inviato")
            return cell
            
        } else {
            let cell = tableview.dequeueReusableCell(withIdentifier: "cellricevuto", for: indexPath) as! ConversazionCell
            cell.lblData.text = "\(NSDate())"
            cell.lblMessaggio.text = messaggio.0
            cell.vinvio.layer.cornerRadius = 30.0
            cell.clipsToBounds = true
            print("ricevuto")
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    @objc func tastieraDentro (notifica: Notification) {
        tastieraInOut (su:false, notifica: notifica)
    }
    
    @objc func tastieraFuori (notifica: Notification) {
        tastieraInOut (su:true, notifica: notifica)
    }
    

    func tastieraInOut (su:Bool,  notifica:Notification) {
        guard su != tastieraSu else {
            return
            
        }
        let info = notifica.userInfo
        let fineTastiera: CGRect = ((info?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue)!
        
        let durataAnimazione: TimeInterval = info? [UIKeyboardAnimationDurationUserInfoKey] as! Double
        
        UIView.animate (withDuration: durataAnimazione, delay: 0, options:
            .curveEaseInOut, animations: {
            let dimensioneTastiera = self.view.convert ( fineTastiera, to:nil)
            let spostamentoVerticale = dimensioneTastiera.size.height * (su ? -1 : 1)
            self.view.frame = self.view.frame.offsetBy( dx: 0, dy: spostamentoVerticale)
                self.tastieraSu = !self.tastieraSu
       }, completion:
            { success in
            if !self.tastieraSu {
                let indice = IndexPath.init(row: self.messaggi.count - 1, section: 0)
                self.tableview.scrollToRow(at: indice, at: .top, animated: true)
                }
            }
            
)
        
    }
    
    
    
    
    
    
    
}
/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destinationViewController.
 // Pass the selected object to the new view controller.
 }
 */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
