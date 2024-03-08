//
//  SnoozerApp.swift
//  Snoozer
//
//  Created by David Strupinski on 2/8/24.
//

import SwiftUI
import PostgresNIO
import Combine
import Logging

@main
struct SnoozerApp: App {
    static var connectionManager = PostgreSQLConnectionManager()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(Self.connectionManager)
        }
    }
}

class PostgreSQLConnectionManager: ObservableObject {
    @Published var connection: PostgresConnection?
    private let logger = Logger(label: "postgres")
    private var cancellables = Set<AnyCancellable>()

    init() {
        // Open the connection when the app starts
        setupDatabase()
        
        // Subscribe to app lifecycle events
        NotificationCenter.default.publisher(for: UIApplication.willTerminateNotification)
            .sink { _ in
                // Close the connection when the app is about to terminate
                self.closeConnection()
            }
            .store(in: &cancellables)
    }
    
    func setupDatabase() {
        let config = PostgresConnection.Configuration(
            host: "localhost",
            port: 5432,
            username: "dna",
            password: "nathansuckseggs",
            database: "dna_db",
            tls: .disable
        )
        
        Task {
            do {
                let connection = try await PostgresConnection.connect(
                    configuration: config,
                    id: 1,
                    logger: logger
                )
                
                // close previous connection if exists
                closeConnection()
                
                DispatchQueue.main.async {
                    self.connection = connection
                }
                print("Connected to postgres")
            } catch {
                print("Connection failed: \(error.localizedDescription)")
            }
        }
    }
    
    func closeConnection() {
        connection?.close().whenComplete { _ in
            print("Connection closed")
            DispatchQueue.main.async {
                _ = self.connection?.close()
            }
        }
    }
}
