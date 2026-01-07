def setup_chat_views
  # Define Theme Configuration for Chat UI to match Global Theme
  @chat_theme = case @selected_theme
  when 'pnw'
    {
      body: "bg-[#F0F4F2] text-[#1A2621] font-serif",
      sidebar: {
        container: "bg-[#1A2621] border-r border-[#2C5530]",
        header_border: "border-[#2C5530]",
        header_text: "text-white tracking-widest",
        link_base: "text-[#A3B18A] hover:text-white hover:bg-[#2C5530]",
        link_active: "bg-[#2C5530] text-white",
        back_link: "text-[#A3B18A] hover:text-white",
        btn: "bg-[#2C5530] hover:bg-[#1C3820] border border-[#A3B18A] text-white"
      },
      main: {
        bg: "bg-[#F0F4F2]",
        header_border: "border-[#2C5530]/20",
        header_text: "text-[#1A2621]",
        placeholder: "text-[#1A2621]/40",
        input_container: "bg-[#F0F4F2] border-t border-[#2C5530]/20",
        input: "bg-white border-[#2C5530]/30 text-[#1A2621] placeholder:text-[#1A2621]/40 focus:ring-[#2C5530]",
        loader_color: "bg-[#2C5530]",
        loader_text: "text-[#2C5530]"
      },
      message: {
        user_bg: "bg-[#2C5530] text-white",
        user_icon: "bg-[#1A2621]",
        bot_bg: "bg-white border border-[#2C5530]/10 text-[#1A2621]",
        bot_icon: "bg-[#A3B18A]",
        source_box: "bg-[#1A2621]/5 border-[#1A2621]/10",
        source_link: "hover:bg-[#1A2621]/10 text-[#2C5530]"
      }
    }
  when 'caribbean'
    {
      body: "bg-gradient-to-br from-cyan-50 via-white to-orange-50 text-slate-700 font-sans",
      sidebar: {
        container: "bg-white/80 backdrop-blur-md border-r border-sky-100",
        header_border: "border-sky-100",
        header_text: "text-sky-600 tracking-tight",
        link_base: "text-slate-500 hover:text-sky-600 hover:bg-sky-50",
        link_active: "bg-sky-100 text-sky-700",
        back_link: "text-slate-400 hover:text-sky-600",
        btn: "bg-sky-500 hover:bg-sky-600 text-white shadow-lg shadow-sky-200 rounded-full"
      },
      main: {
        bg: "bg-transparent",
        header_border: "border-sky-100 bg-white/50 backdrop-blur",
        header_text: "text-slate-700",
        placeholder: "text-sky-900/30",
        input_container: "bg-white/50 backdrop-blur border-t border-sky-100",
        input: "bg-white border-sky-100 text-slate-700 shadow-sm focus:ring-sky-500 placeholder:text-slate-400",
        loader_color: "bg-sky-500",
        loader_text: "text-sky-600"
      },
      message: {
        user_bg: "bg-sky-500 text-white shadow-md shadow-sky-100",
        user_icon: "bg-sky-600",
        bot_bg: "bg-white/80 border border-sky-50 text-slate-700 shadow-sm",
        bot_icon: "bg-orange-400",
        source_box: "bg-sky-50/50 border-sky-100",
        source_link: "hover:bg-sky-100 text-sky-600"
      }
    }
  else # Default (Light clean)
    {
      body: "bg-white text-gray-900 font-sans",
      sidebar: {
        container: "bg-gray-50 border-r border-gray-200",
        header_border: "border-gray-200",
        header_text: "text-gray-900 tracking-tight",
        link_base: "text-gray-600 hover:bg-gray-200 hover:text-gray-900",
        link_active: "bg-white shadow-sm ring-1 ring-gray-200 text-gray-900",
        back_link: "text-gray-500 hover:text-gray-900",
        btn: "bg-gray-900 hover:bg-gray-800 text-white"
      },
      main: {
        bg: "bg-white",
        header_border: "border-gray-100",
        header_text: "text-gray-900",
        placeholder: "text-gray-400",
        input_container: "bg-white border-t border-gray-100",
        input: "bg-gray-50 border-gray-200 text-gray-900 focus:bg-white focus:ring-gray-900 placeholder:text-gray-500",
        loader_color: "bg-gray-900",
        loader_text: "text-gray-600"
      },
      message: {
        user_bg: "bg-gray-900 text-white",
        user_icon: "bg-black",
        bot_bg: "bg-transparent border border-gray-100 text-gray-800",
        bot_icon: "bg-blue-600",
        source_box: "bg-gray-50 border-gray-100",
        source_link: "hover:bg-gray-100 text-blue-600"
      }
    }
  end

  setup_chat_view_layout
  setup_chat_view_index
  setup_chat_view_show
  setup_chat_view_helpers
  setup_chat_view_sources_partial
  setup_chat_view_message_partial
  setup_chat_view_tailwind
end