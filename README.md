# GACS - Eulerity iOS Take-Home Exercise

# Today-Only Todo App

## My Technical Decisions and TradeOffs

1. MVVM Architecture:
    
    Decision:
    All the business logic is seperated and is in the TaskViewModel
    
    Reason:
    * Aligns with the SwiftUI Declarative Nature.
    * Business logic is testable
    * Better seperation of concern.
    

2. Storage Choice:
    
    Decision:
    Used UserDefaults for Persistence
    
    Reason:
    * Dataset is small
    * Handling only today only tasks.
    * Easy to implement for this usecase.
    
    TradeOff:
    * Not scalable for larger datasets.
    * No advance querying.
    
3. Notification Strategy

    Decision:
    Single end of day reminder at 11 PM.
    
    Reason:
    * It's a today only task so all the tasks will expire at midnight. So only one notification makes sense if active tasks are present.
    * Avoids Notification spam.
    
    Tradoff:
    * No per task notification.
    
4. Midnight Reset Strategy

    Previous day Tasks automatically gets cleared at midnight if app is open and gets cleared on app launch if app is closed and opened after midnight.
    
    Decision:
    Used Notification Observer to observe iOS triggered Notification .NSCalendarDayChanged to clear previous tasks and also on app launch, clearTasks method is called which checks the date and clear previous day tasks.
    
    Reason:
    * Notification is System-driven.
    * Accurate at midnight.
    * Works even if app is open.
    
    
## Things I would like to improve

1. Option to add expiration time for tasks.
2. Reminder Notification per task based on expiration time of tasks.
    
    
    
