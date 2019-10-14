//
//  databaselib.swift
//  mactestnew2
//
//  Created by Felix 05 on 04/10/19.
//  Copyright © 2019 felix. All rights reserved.
//

import Foundation
import SQLite3
class databaselib
{
    static let shareObj = databaselib()
    var P_Name = [String]()
    var P_Rate = [String]()
    func databasePath() -> String
    {
        let dir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let path = dir.first!
        return path+"myDatabase.sqlite"
    }
    func executeQuery(query:String) ->Bool
    {
        var success: Bool = false
        var db:OpaquePointer? = nil
        var stmt:OpaquePointer? = nil
        let dbPath = databasePath()
        
        if sqlite3_open(dbPath, &db) == SQLITE_OK
        {
            if sqlite3_prepare_v2(db, query, -1, &stmt, nil) == SQLITE_OK
            {
                if sqlite3_step(stmt) == SQLITE_DONE
                {
                    success = true
                }
                    
                else
                {
                    print("error in step:\(sqlite3_errmsg(stmt))")
                }
            }
            else
            {
                print("error in prepare:\(sqlite3_errmsg(stmt))")
            }
        }
        else
        {
            print("error in Open:\(sqlite3_errmsg(stmt))")
        }
        return success
    }
    func selectall(query:String)
    {
        
        var db:OpaquePointer? = nil
        var stmt:OpaquePointer? = nil
        let dbPath = databasePath()
        
        if sqlite3_open(dbPath, &db) == SQLITE_OK
        {
            if sqlite3_prepare_v2(db, query, -1, &stmt, nil) == SQLITE_OK
            {
                P_Name.removeAll()
                P_Rate.removeAll()
                while sqlite3_step(stmt) == SQLITE_ROW
                {
                    let pname = sqlite3_column_text(stmt, 1)
                    let productname = String(cString: pname!)
                    P_Name.append(productname)
                    let pid = sqlite3_column_text(stmt, 0)
                    let productrate = String(cString:pid!)
                    P_Rate.append(productrate)
                }
                print(P_Rate)
            }
                
            else
            {
                print("error in prepare:\(sqlite3_errmsg(stmt))")
            }
        }
        else
        {
            print("error in Open:\(sqlite3_errmsg(stmt))")
        }
        
    }
    func createTable()
    {
        let createQuery = "create table if not exists ManufactringTable(P_Name text, P_Rate text)"
        let isSuccess = executeQuery(query: createQuery)
        if isSuccess
            
        {
            print("table creation:success")
            
        }
        else{
            print("table creation:failed")
        }
    }
}
