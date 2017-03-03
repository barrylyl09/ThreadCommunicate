
#线程间通信
维基百科：指至少两个线程间传送数据或信号的一些方法
##线程间通信的体现
- 一个线程传递数据给另一个线程
- 在一个线程中执行完特定任务后，转到另一个线程继续执行任务

###NSThread
- 在指定线程上执行操作

`[self performSelector:@selector(operate) onThread:thread withObject:nil waitUntilDone:YES]`

- 在主线程上执行操作

`[self performSelectorOnMainThread:@selector(operate) withObject:nil waitUntilDone:YES]`

例：子线程下载图片，然后回主线程刷新UI

##线程共享内存空间
- 优点：线程安全，自动加锁
- 缺点：消耗大量资源（为保证线程安全，会不停加锁）

```oc
static MyClass _instance

+(id)shareInstance {
		static dispatch_once_t onceToken;
		dispatch_once (&onceToken, ^{
					if(_instance == nil) _instance = [[MyClass alloc] init];
				  });
				  
				  return _instance;
}
```

##添加线程依赖关系

- NSOperation：可以利用 `NSOperationqueue` 控制单个线程之间关系。  
`addDependency:` 添加依赖关系  
`removeDependency:` 删除依赖关系

```oc
NSOperationQueue *queue = [[NSOperationQueue alloc] init];  
  
NSBlockOperation *operation1 = [NSBlockOperation blockOperationWithBlock:^(){  
    NSLog(@"执行NO.1操作，线程：%@", [NSThread currentThread]);  
}];  
  
NSBlockOperation *operation2 = [NSBlockOperation blockOperationWithBlock:^(){  
    NSLog(@"执行NO.2操作，线程：%@", [NSThread currentThread]);  
}];  
// operation1依赖于operation2  (先执行operation2)
[operation1 addDependency:operation2];  
  
[queue addOperation:operation1];  
[queue addOperation:operation2]; 
```
####operation切勿循环依赖！！！

- GCD: `dispatch groups`是专门用来监视多个异步任务。`dispatch_group_t `实例用来追踪不同队列中的不同任务。

####当group里所有事件都完成GCD API有两种方式发送通知。  
第一种：是`dispatch_group_wait`，会阻塞当前进程，等所有任务都完成或等待超时。  
第二种：是`dispatch_group_notify`，异步执行闭包，不会阻塞。


```oc
dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);


dispatch_async(queue, ^{

    dispatch_group_t group = dispatch_group_create();

    __block UIImage *img1 = nil;
    __block UIImage *img2 = nil;


    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        img1 = [self loadImg:imgUrl1];
    });

    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        img2 = [self loadImg:imgUrl2];
    });


    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        self.imgview1.image = img1;
        self.imgView2.image = img2;

    });
});
```

##信号量（semaphore）
###如何控制线程并发量

- NSOperation: 我们可以利用`NSOperationqueue`来控制单个线程间关系, `setMaxConcurrentOperationCount` 这个函数来控制最大并发量。

```oc
NSOperationQueue *queue = [[NSOperationQueue alloc] init];  

//每次执行‘number’个操作
[queue setMaxConcurrentOperationCount:number];
```

####GCD: 在GCD中我们可以利用dispatch_semaphore（信号量）来处理控制并发。

####信号量：是一个整形值并且具有一个初始计数值。有两个操作分别为：通知和等待。

￼

- dispatch_semaphore_create: 创建一个整形数值的信号，即：信号的总量

- dispatch_semaphore_signal: 发送一个信号,让信号总量增加1

- dispatch_semaphore_wait: 首先判断信号量是否大于零，如果大于零则减掉1个信号量，往下执行，如果等于零则阻塞该线程
###**补充一个 DEMO：[链接](https://github.com/barrylyl09/ThreadCommunicate)**
