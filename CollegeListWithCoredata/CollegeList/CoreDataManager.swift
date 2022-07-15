//
//  CoreDataManager.swift
//  CollegeList
//
//  Created by zoho on 11/07/22.
//2dc3524462524b9492456a138fad193b

import Foundation
import UIKit
import CoreData

class CoreDataManager {
    let apiHandler = APIHandler()
    let persistentContainer = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
    var viewContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    private func saveContext() {
        do {
            try self.viewContext.save()
            print("saved")
        } catch {
            print(error)
        }
    }
    private func fetchApiData(completion: @escaping ([CountriesAndCollegesModel])->Void) {
        apiHandler.fetchCountryData(){ results in
            completion(results)
        }
    }
    
    func saveApiData(completion: @escaping (([String])->Void)) {
        do {
            let results = try viewContext.fetch(CountriesAndColleges.fetchRequest()) as [CountriesAndColleges]
            for collegeAndCountry in results {
                let managedObjectData:NSManagedObject = collegeAndCountry as NSManagedObject
                viewContext.delete(managedObjectData)
            }
            print("done delete")
        } catch {
            print(error)
        }
        var countryNames = [String]()
        self.fetchApiData() { results in
            print("saving..")
            for country in results {
                let countries = CountriesAndColleges(context: self.viewContext)
                countries.setValue(country.collegeName.unwrap, forKey: "collegeName")
                countries.setValue(country.countryName.unwrap, forKey: "countryName")
                countryNames.append(country.countryName.unwrap)
            }
            self.saveContext()
            completion(countryNames)
        }
    }
    
    
    func fetchCoreData(completion: @escaping (([String])->Void)) {
        print("fetching")
        do {
            let results = try viewContext.fetch(CountriesAndColleges.fetchRequest()) as [CountriesAndColleges]
            if results.count == 0 {
                saveApiData() { countries in
                    completion(countries.uniqueAndSort)
                }
            } else {
                completion(getCountries(from: results))
            }
            print("fetch results: ", results.count)
        } catch {
            print("fetch err ", error)
        }
    }
    func remove(_ countryName: String) {
        let predicate = NSPredicate(format: "countryName = %@", countryName)
        let fetchRequest = NSFetchRequest<CountriesAndColleges>.init(entityName: "CountriesAndColleges")
        fetchRequest.predicate = predicate
        do {
            let results = try viewContext.fetch(fetchRequest)
            for result in results {
                let managedObject: NSManagedObject = result as NSManagedObject
                viewContext.delete(managedObject)
            }
            print("del..")
            }catch {
                print(error)
            }
        self.saveContext()
    }
    
    func checkDataChanges(_ coreDataCountries: [String], completion: (([String])->Void)? = nil) {
//        let backgroundContext = persistentContainer.newBackgroundContext()
//        backgroundContext.automaticallyMergesChangesFromParent = true
        saveApiData { (countries) in
            let newCountries = countries.uniqueAndSort.filter({!coreDataCountries.contains($0)})
            completion?(newCountries)
        }
    }
    
    func fetchCountry(_ selectedCountry: String, completion: (([CountriesAndColleges])->Void)) {
        
        let predicate = NSPredicate(format: "countryName = %@", selectedCountry)
        let fetchRequest = NSFetchRequest<CountriesAndColleges>.init(entityName: "CountriesAndColleges")
        fetchRequest.predicate = predicate
        
        do {
            let filteredColleges = try viewContext.fetch(fetchRequest)
            completion(filteredColleges)
        } catch {
            print("CollegeFetchingError: ", error)
        }
    }
}

extension CoreDataManager {
    private func getCountries(from countriesAndColleges: [CountriesAndColleges]) -> [String]{
        var countries = [String]()
        countriesAndColleges.forEach({countries.append($0.countryName.unwrap)})
        return countries.uniqueAndSort
    }
    
    func addNewCollege(_ countryAndCollege: CountriesAndCollegesModel, completion: @escaping (String)->Void){
        let college = countryAndCollege.collegeName.unwrap
        let country = countryAndCollege.countryName.unwrap
        if self.checkExistingCollege(collegeName: college, countryName: country) {
            let newCountryAndCollege = CountriesAndColleges(context: viewContext)
            newCountryAndCollege.collegeName = college
            newCountryAndCollege.countryName = country
        }
        do {
            if viewContext.hasChanges {
                try viewContext.save()
                completion(countryAndCollege.countryName.unwrap)
            }
            print("saved new")
        } catch {
            print("error in saving: ", error)
        }
        
    }
    
    func checkExistingCollege(collegeName: String, countryName: String) -> Bool {
        let predicate = NSPredicate(format: "collegeName = %@ AND countryName = %@", collegeName, countryName)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "CountriesAndColleges")
        fetchRequest.predicate = predicate
        do {
            let college = try viewContext.fetch(fetchRequest)
            return college.isEmpty
        } catch {
            print(error)
        }
        return false
    }
}
