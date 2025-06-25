<template>
  <div class="min-h-screen bg-gray-50">
    <!-- 导航栏 -->
    <AppNavigation 
      title="申请交换"
      :show-back-button="true"
      :back-route="route('courses.index')"
      back-text="返回課程列表"
    />

    <div class="max-w-4xl mx-auto py-6 px-4 sm:px-6 lg:px-8">
      <!-- 错误消息 -->
      <div v-if="$page.props.flash?.error" 
           class="mb-6 bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative">
        {{ $page.props.flash.error }}
      </div>

      <div class="bg-white rounded-lg shadow p-6">
        <!-- 目标課程信息 -->
        <div class="mb-6">
          <h2 class="text-lg font-semibold text-gray-900 mb-3">您想要的課程</h2>
          <div class="bg-green-50 p-4 rounded-lg">
            <h3 class="text-lg font-medium text-green-900">{{ targetCourse.course_name }}</h3>
            <div class="mt-2 space-y-1 text-sm text-green-800">
              <p><span class="font-medium">課程代碼:</span> {{ targetCourse.course_code }}</p>
              <p><span class="font-medium">授課教師:</span> {{ targetCourse.instructor }}</p>
              <p><span class="font-medium">上課時間:</span> {{ targetCourse.time_slot }}</p>
              <p><span class="font-medium">上課地點:</span> {{ targetCourse.location }}</p>
              <p><span class="font-medium">學分:</span> {{ targetCourse.credits }}</p>
              <p><span class="font-medium">發布者:</span> {{ targetCourse.user.name }}</p>
            </div>
            <div v-if="targetCourse.description" class="mt-2 text-sm text-green-700">
              <p><span class="font-medium">課程描述:</span> {{ targetCourse.description }}</p>
            </div>
          </div>
        </div>

        <!-- 交換表單 -->
        <form @submit.prevent="submit" class="space-y-6">
          <div>
            <label class="block text-sm font-medium text-gray-700 mb-3">
              選擇您要用來交換的課程 *
            </label>
            <div v-if="myCourses.length === 0" class="text-gray-500 text-center py-8">
              <p>您還沒有可用於交換的課程</p>
              <Link :href="route('courses.create')" 
                    class="text-blue-600 hover:text-blue-800 underline">
                先發布一個課程
              </Link>
            </div>
            <div v-else class="space-y-3">
              <div v-for="course in myCourses" :key="course.id" 
                   class="relative">
                <label class="flex items-start p-4 border border-gray-200 rounded-lg cursor-pointer hover:bg-gray-50"
                       :class="{ 'border-blue-500 bg-blue-50': form.requester_course_id == course.id }">
                  <input
                    v-model="form.requester_course_id"
                    :value="course.id"
                    type="radio"
                    class="mt-1 h-4 w-4 text-blue-600 focus:ring-blue-500 border-gray-300"
                    required
                  />
                  <div class="ml-3 flex-1">
                    <h4 class="text-lg font-medium text-gray-900">{{ course.course_name }}</h4>
                    <div class="mt-1 space-y-1 text-sm text-gray-600">
                      <p><span class="font-medium">課程代碼:</span> {{ course.course_code }}</p>
                      <p><span class="font-medium">授課教師:</span> {{ course.instructor }}</p>
                      <p><span class="font-medium">上課時間:</span> {{ course.time_slot }}</p>
                      <p><span class="font-medium">上課地點:</span> {{ course.location }}</p>
                      <p><span class="font-medium">學分:</span> {{ course.credits }}</p>
                    </div>
                    <div v-if="course.description" class="mt-2 text-sm text-gray-700">
                      <p>{{ course.description }}</p>
                    </div>
                  </div>
                </label>
              </div>
            </div>
            <p v-if="form.errors.requester_course_id" class="mt-1 text-sm text-red-600">
              {{ form.errors.requester_course_id }}
            </p>
          </div>

          <div>
            <label for="message" class="block text-sm font-medium text-gray-700">
              給對方留言
            </label>
            <textarea
              id="message"
              v-model="form.message"
              rows="4"
              class="mt-1 block w-full px-4 py-3 text-gray-900 border-gray-300 rounded-lg shadow-sm focus:ring-2 focus:ring-blue-500 focus:border-blue-500 text-base resize-none"
              :class="{ 'border-red-500': form.errors.message }"
              placeholder="向对方说明您的交换意愿，比如为什么想要这个課程，您的課程有什么特色等..."
            ></textarea>
            <p v-if="form.errors.message" class="mt-1 text-sm text-red-600">
              {{ form.errors.message }}
            </p>
          </div>

          <div class="flex justify-end space-x-3" v-if="myCourses.length > 0">
            <Link :href="route('courses.index')" 
                  class="bg-gray-300 text-gray-700 px-4 py-2 rounded-md hover:bg-gray-400 transition-colors">
              取消
            </Link>
            <button
              type="submit"
              :disabled="form.processing"
              class="bg-blue-600 text-white px-4 py-2 rounded-md hover:bg-blue-700 transition-colors disabled:opacity-50"
            >
              <span v-if="form.processing">發送中...</span>
              <span v-else>發送交換請求</span>
            </button>
          </div>
        </form>
      </div>
    </div>

    <!-- 页脚 -->
    <AppFooter />
  </div>
</template>

<script setup>
import { Link, useForm } from '@inertiajs/vue3'
import AppNavigation from '@/components/AppNavigation.vue'
import AppFooter from '@/components/AppFooter.vue'

const props = defineProps({
  targetCourse: Object,
  myCourses: Array,
})

const form = useForm({
  requester_course_id: '',
  target_course_id: props.targetCourse.id,
  message: '',
})

const submit = () => {
  form.post(route('exchanges.store'))
}
</script>
