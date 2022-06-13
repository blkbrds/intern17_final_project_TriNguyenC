//
//  DetailViewModel.swift
//  Final_Project
//
//  Created by tri.nguyen on 23/05/2022.
//

import Foundation
import RealmSwift

final class DetailViewModel {
 
    // MARK: - Properties
    var new: New
    
    // MARK: - Init
    init(new: New) {
        self.new = new
    }
        
    // MARK: - Load Image
    func getImageURL() -> URL? {
        let url = URL(string: new.urlToImage)
        return url
    }
    
    // MARK: - Realm
    func isAddedRealm() -> Bool {
        /// Fetch all objects news from Realm
        /// Check news.contain(new)
        /// If yes: call remove function
        /// If no: call add function
        
        do {
            let realm = try Realm()
            
            let newsResult = realm.objects(New.self).filter("title == %@", new.title)
            let news = Array(newsResult)
            return news.isNotEmpty
            
        } catch {
            print("Error Of Object From Realm")
            return false
        }
    }

    func addToRealm() {
        /// Add new to realm
        do {
            let realm = try Realm()
            try realm.write {
                realm.create(New.self, value: new, update: .all)
            }
        } catch {
            print("Error Of Object From Realm")
        }
    }

    func removeFromRealm() {
        /// Remove new from realm
        do {
            let realm = try Realm()
            let newsResult = realm.objects(New.self).filter("title = %@", new.title)
            guard let new = Array(newsResult).first else { return }
            try realm.write {
                realm.delete(new)
            }
        } catch {
            print("Error Of Object From Realm ")
        }
    }
}

// MARK: - Dummy Data
extension DetailViewModel {
    
    struct Config {
        static let dummyData: String = "If the 54 letters have already been submitted, Sir Graham, chairman of the Conservatives’ backbench 1922 Committee, could make an announcement as soon as this morning. Observers expect any confidence vote to take place on Wednesday.One Conservative MP said that if the announcement is not made tomorrow, it is likely any vote would be deferred until after the by-elections in Wakefield and Tiverton in Devon on June 23. Last night Mr Zahawi told the Daily Mail: ‘People do not vote for divided teams. We are strongest when we are united and focused on delivery for the British people. The PM has got the big calls right: be it on Brexit, vaccines or leading us out of the pandemic. We need to get behind him.’Meanwhile, Mr Shapps told the BBC’s Sunday Morning yesterday that Mr Johnson would lead the Conservatives into a general election victory because the issues that ‘matter to people’ are Brexit and economic growth.He dismissed the mixed reception received by the PM as he attended a service for the Queen at St Paul’s Cathedral on Friday, where boos could be heard from the crowd. Mr Shapps noted that there were also cheers and said ‘politicians don’t expect to be popular all the time’.A defiant Boris Johnson will launch a fightback against his critics this week by unveiling plans to tackle NHS inefficiency and expand the right to buy social housing.Despite the threat of a ballot on his leadership, the Prime Minister will make it clear that his Government plans to focus on policies that can win the next election for the Conservatives.The idea is to show that Mr Johnson is still brimming with ideas for improving the country – and that it would be foolish for his MPs to get rid of him.This week will see a slew of health announcements, including the revelation today that the NHS has carried out 1million checks for cancer and other diseases as part of a post-pandemic catch-up programme. Health Secretary Sajid Javid will also publish a report by Sir Gordon Messenger, a former Royal Marine general who served in Iraq and Afghanistan, into the future of NHS management.The review will look at ways of replicating good leadership across the NHS, and ensuring that the best leaders are attracted to the health service.The Government will also expand on its plans to extend the right to buy, one of Margaret Thatcher’s flagship policies.Mr Johnson wants to make it easier for people who live in housing association properties to buy their own homes. A No 10 source said: ‘This week the Prime Minister will be focusing on important issues the public want us to address, such as the NHS, the cost of living, and housing.’Former Tory leader Sir Iain Duncan Smith urged Mr Johnson to unveil more traditional Conservative policies, such as tax cuts.He said: ‘Will the Conservative Government please stand up. Boris Johnson and the Conservative Party need to stand up and become Conservative in government.‘Those in the squeezed middle have seen taxes rise dramatically. The Conservatives need to cut taxes to ease the pain of the crisis.’In a speech this week, Mr Johnson will say that he wants 2.5million people who rent housing association properties to have the chance to buy their homes at a discount.He is also expected to signal his support for the construction of more ‘flat-pack’ homes.This week ministers will also update the public on how the NHS is delivering the ‘biggest ever catch-up programme’, with a vast expansion in scans and tests in community clinics. Since February the number of patients waiting more than two years for treatment has more than halved.Sir Gordon’s findings on the NHS come after a sharp increase in central bureaucracy in the NHS. The doubling in the numbers working in NHS England and the Department of Health and Social Care – with the biggest rises seen at the highest levels – over the last two years come at a time when the nursing workforce rose by just 7 per cent.The figures show the central workforce rose from 7,883 to 14,515, with the number of senior officials rising by 125 per cent, as the pay bill went from £42million to £83million.Sir Gordon is also understood to be concerned that too much NHS management energy is focused on immediate and short-term tasks, with too little attention paid to the long-term agenda."
    }
}
