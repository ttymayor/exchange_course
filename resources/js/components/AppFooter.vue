<template>
    <footer class="bg-gray-800 text-white py-8 mt-12">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
                <!-- 關於我們 -->
                <div>
                    <h3 class="text-lg font-semibold mb-4">關於課程交換平台</h3>
                    <p class="text-gray-300 text-sm leading-relaxed">
                        為大學生提供便捷的課程交換服務，讓學習更靈活，選擇更多樣。
                        找到你想要的課程，交換你現有的課程，讓學習之路更加精彩。
                    </p>
                </div>

                <!-- 快速連結 -->
                <div>
                    <h3 class="text-lg font-semibold mb-4">快速連結</h3>
                    <ul class="space-y-2 text-sm text-gray-300">
                        <li>
                            <Link :href="route('courses.index')" class="hover:text-white transition-colors">
                                瀏覽課程
                            </Link>
                        </li>
                        <li>
                            <Link :href="route('courses.create')" class="hover:text-white transition-colors">
                                發佈課程
                            </Link>
                        </li>
                        <li>
                            <Link :href="route('exchanges.index')" class="hover:text-white transition-colors">
                                我的交換
                            </Link>
                        </li>
                    </ul>
                </div>

                <!-- 聯絡資訊 -->
                <div>
                    <h3 class="text-lg font-semibold mb-4">聯絡作者</h3>
                    <div class="space-y-2 text-sm text-gray-300">
                        <p>📧 信箱: me@ttymayor.com</p>
                        <div class="flex space-x-4 mt-4">
                            <a href="https://github.com/ttymayor" class="text-gray-300 hover:text-white transition-colors">
                                <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20">
                                    <path fill-rule="evenodd" d="M10 0C4.477 0 0 4.484 0 10.017c0 4.425 2.865 8.18 6.839 9.504.5.092.682-.217.682-.483 0-.237-.008-.868-.013-1.703-2.782.605-3.369-1.343-3.369-1.343-.454-1.158-1.11-1.466-1.11-1.466-.908-.62.069-.608.069-.608 1.003.07 1.531 1.032 1.531 1.032.892 1.53 2.341 1.088 2.91.832.092-.647.35-1.088.636-1.338-2.22-.253-4.555-1.113-4.555-4.951 0-1.093.39-1.988 1.029-2.688-.103-.253-.446-1.272.098-2.65 0 0 .84-.27 2.75 1.026A9.564 9.564 0 0110 4.844c.85.004 1.705.115 2.504.337 1.909-1.296 2.747-1.027 2.747-1.027.546 1.379.203 2.398.1 2.651.64.7 1.028 1.595 1.028 2.688 0 3.848-2.339 4.695-4.566 4.942.359.31.678.921.678 1.856 0 1.338-.012 2.419-.012 2.747 0 .268.18.58.688.482A10.019 10.019 0 0020 10.017C20 4.484 15.522 0 10 0z" clip-rule="evenodd" />
                                </svg>
                            </a>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 分隔線 -->
            <div class="border-t border-gray-700 mt-8 pt-6">
                <div class="flex flex-col md:flex-row justify-between items-center">
                    <div class="text-sm text-gray-400">
                        © {{ currentYear }} 課程交換平台. 保留所有權利.
                    </div>
                    <div class="flex space-x-6 mt-4 md:mt-0">
                        <!-- <a href="#" class="text-gray-400 hover:text-white text-sm transition-colors">
                            隱私政策
                        </a>
                        <a href="#" class="text-gray-400 hover:text-white text-sm transition-colors">
                            服務條款
                        </a>
                        <a href="#" class="text-gray-400 hover:text-white text-sm transition-colors">
                            幫助中心
                        </a> -->
                    </div>
                </div>
            </div>
        </div>
    </footer>
</template>

<script setup>
import { Link } from '@inertiajs/vue3'
import { computed } from 'vue'

const currentYear = computed(() => new Date().getFullYear())
</script>
