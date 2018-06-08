//
//  DBManagerConnector.swift
//  COpenSSL
//
//  Created by Giorgio on 23/05/2018.
//

import Foundation
import mysqlclient
import PerfectMySQL


class DBManagerConnector{
    let testHost = "127.0.0.1"
    let testUser = "root"
    let testPassword = "giorgio1996"
    let testDB = "mydb"
    let mysql: MySQL?
    
    init() {
         mysql = MySQL()
        let connected = mysql?.connect(host: testHost, user: testUser, password: testPassword)
        
        guard connected! else{
            //verifica che si è connesso correttamente
            print(mysql?.errorMessage())
            return
        }
        defer {
            mysql?.close()
        }
        guard (mysql?.selectDatabase(named: testDB))! else{
           
        //manca Log.info(message: "Failure: \(mysql.errorCode()) \(dataMysql.errorMessage())")
        return
        }
        
    }
    
    
    func query(query:String)throws -> [[String:Any]]{
        let b = MySQLStmt(mysql!)
        var ary = [[String:Any]]()
//        guard b.prepare(statement: query) else{
//
//            throw ErroriDiDB.NoEsecuzioneQuery
//        }
        
       
        b.prepare(statement: query)
        b.execute()
    
        let res = b.results()
        var i = 0
        let fields = b.fieldNames()
        if(res.numRows==0){
            
            throw ErroriDiDB.noResult
        }
        res.forEachRow { (ele) in
            var a = [String:Any]()
            ele.forEach({ (fieldVal) in
                
                a[fields[i]!] = fieldVal!
                
                i = i+1
                
            })
            ary.append(a)
            i=0
        }

        return ary
        
    }
    func queryINSERT(query:String)throws -> [[String:Any]]{
        //questa nuova funzione ci permette di ottenere un id generato automaticamente dal Database
        let b = MySQLStmt(mysql!)
        var ary = [[String:Any]]()
        
        executeQuery(bi: b, query: query)
        let res = b.results()
        var i = 0
        let fields = b.fieldNames()
        if(res.numRows==0){
            
            throw ErroriDiDB.noResult
        }
        res.forEachRow { (ele) in
            var a = [String:Any]()
            ele.forEach({ (fieldVal) in
                
                a[fields[i]!] = fieldVal!
                
                i = i+1
                
            })
            ary.append(a)
            i=0
        }
        
        return ary
        
    }
    
    func executeQuery(bi: MySQLStmt, query: String) {
        sync()
        bi.prepare(statement: query)
        bi.execute()
        bi.prepare(statement: "SELECT CAST(last_insert_id() as CHAR)")
        bi.execute()
        
    }
}


enum ErroriDiDB: Error {
    case NoEsecuzioneQuery
    case noResult
    
    
    
}

