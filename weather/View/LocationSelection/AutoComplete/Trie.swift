//
//  Trie.swift
//  weather
//
//  Created by Abdelrahman Sobhy on 24/07/2021.
//

import Foundation

class Trie {
    struct TrieNode {
        var childs = [Character : TrieNode]()
        var isWord = false
        var theWord = ""
    }
    var head = TrieNode()
    var tmpResults = [String]()
    
    func insert(word: String, idx: Int = 0, curNode: inout TrieNode) {
        if idx == word.count { // end of the word
            curNode.isWord = true
            curNode.theWord = word
            return
        }
        let char = Character(word[idx].uppercased())
        if curNode.childs[char] == nil{ // create node for char if not exist
            curNode.childs[char] = TrieNode()
        }
        // insert the char at idx as a child for the curNode
        insert(word: word, idx: idx + 1, curNode: &curNode.childs[char]!)
    }
    
    func match(prefix: String) -> [String] {
        tmpResults = [String]()
        if let node = getNode(for: prefix, curNode: head) { // prefix exist
            getLeafes(from: node)
        }
        return tmpResults
    }
    
    private func getNode(for prefix: String, idx: Int = 0, curNode: TrieNode) -> TrieNode? {
        if idx == prefix.count {
            return curNode
        }
        let char = Character(prefix[idx].uppercased())
        if let child = curNode.childs[char] {
            return getNode(for: prefix, idx: idx + 1, curNode: child)
        }else {
            return nil
        }
    }
    
    private func getLeafes(from node: TrieNode) {
        if node.isWord {
            tmpResults.append(node.theWord)
            return
        }
        for child in node.childs {
            getLeafes(from: child.value)
        }
    }
}

extension StringProtocol {
    subscript(offset: Int) -> Character { self[index(startIndex, offsetBy: offset)] }
    subscript(range: Range<Int>) -> SubSequence {
        let startIndex = index(self.startIndex, offsetBy: range.lowerBound)
        return self[startIndex..<index(startIndex, offsetBy: range.count)]
    }
    subscript(range: ClosedRange<Int>) -> SubSequence {
        let startIndex = index(self.startIndex, offsetBy: range.lowerBound)
        return self[startIndex..<index(startIndex, offsetBy: range.count)]
    }
    subscript(range: PartialRangeFrom<Int>) -> SubSequence { self[index(startIndex, offsetBy: range.lowerBound)...] }
    subscript(range: PartialRangeThrough<Int>) -> SubSequence { self[...index(startIndex, offsetBy: range.upperBound)] }
    subscript(range: PartialRangeUpTo<Int>) -> SubSequence { self[..<index(startIndex, offsetBy: range.upperBound)] }
}
